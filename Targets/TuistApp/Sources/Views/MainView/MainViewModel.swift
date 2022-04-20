//
//  MainViewModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

import Domain
import NetworkPlatform

class MainViewModel : ViewModelBuilderProtocol {
    
    
    
    struct Input {
        let searchAction : Driver<String>
        let bottomScrollTriger : Driver<Void>
        let cellClick : Driver<ImageSearchModel>
        let sortTypeAction : Driver<SortType>
    }
    
    struct Output {
        let imageSearchModels : Driver<[ImageSearchSectionModel]>
        let searchClear : Driver<Void>
        let outputError : Driver<Error>
        let outputActivity : Driver<Bool>
        let sortType : Driver<SortType>
    }
    struct Builder {
        let coordinator : MainViewCoordinator
    }
    
    var totalCount : Int = 0
    
    var itemCount : Int = 30
    
    //페이징카운트
    var pagingCount : Int  = 1
    
    
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    
    let imageSearchUseCase : ImageSearchUseCaseInterface
    let builder : Builder
    let disposeBag : DisposeBag = DisposeBag()
    
    required init( imageSearchUseCase : ImageSearchUseCaseInterface , builder : Builder) {
        self.imageSearchUseCase = imageSearchUseCase
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        let mainViewSectionModels = BehaviorSubject<[ImageSearchSectionModel]>(value: [])
        let imageSearchSectionModel = PublishSubject<ImageSearchSectionModel>()
        let searchClear = PublishSubject<Void>()
        let meta = PublishSubject<PagingAbleModel>()
        let scrollPagingCall = PublishSubject<Bool>()
        let sortType = PublishSubject<SortType>()
        
        
        
        
        
        
        imageSearchSectionModel
            .withLatestFrom(mainViewSectionModels) { ($0 , $1) }
            .map{ $0.1.sectionItemEdit(items: $0.0, index: 0) }
            .subscribe (mainViewSectionModels)
            .disposed(by: disposeBag)
        
        
        imageSearchSectionModel
            .subscribe(onNext: { [weak self] sectionModel in
                guard let self = self else { return }
                self.pagingCountSetting(totalCount: sectionModel.items.count)
            })
            .disposed(by: disposeBag)

        imageSearchSectionModel
            .withLatestFrom(meta) { ($0 , $1) }
            .map{ [weak self] (sectionModel , meta) in
                guard let self = self else { return false }
                return self.pagingAbleChecking(paingAble: meta, totalCount: sectionModel.items.count)
            }
            .asDriverOnErrorNever()
            .drive(scrollPagingCall)
            .disposed(by: disposeBag)
        
        Observable.of(input.searchAction , input.sortTypeAction.map{ _ in "" } )
            .merge()
            .asDriverOnErrorNever()
            .drive{  [weak self] _ in
                guard let self = self else { return }
                self.pagingCountClear()
            }
            .disposed(by: disposeBag)
        
       
        let searchAction = input.searchAction
            .asObservable()
            .flatMap { [weak self] keyword -> Observable<(ImageSearchModels , PagingAbleModel)> in
                guard let self = self else { return .never() }
                return self.imageSearchUseCase.imageSearch(query: keyword, sortType: .accuracy, page: self.pagingCount, size: self.itemCount)
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .catch{ error in
                        return .never()
                    }
            }
            .share()
    
        let infinityScroll = input.bottomScrollTriger
            .asObservable()
            .withLatestFrom(scrollPagingCall) { $1 }
            .filter{ $0 }
            .withLatestFrom(Observable.combineLatest(input.searchAction.asObservable() , sortType)) { ($1.0 , $1.1) }
            .flatMap{ [weak self] keyword , sortType  -> Observable<(ImageSearchModels , PagingAbleModel)> in
                guard let self = self else { return .never() }
                return self.imageSearchUseCase.imageSearch(query: keyword, sortType: sortType, page: self.pagingCount, size: self.itemCount)
                    .asObservable()
                    .trackError(self.errorTracker)
                    .catch{ error in
                        return .never()
                    }
            }
            .share()
        
        let sortTypeAction = input.sortTypeAction
            .asObservable()
            .withLatestFrom(input.searchAction) { ($1 , $0) }
            .flatMap{ [weak self] keyword , sortType  -> Observable<(ImageSearchModels , PagingAbleModel)> in
                
                guard let self = self else { return .never() }
                return self.imageSearchUseCase.imageSearch(query: keyword, sortType: sortType, page: self.pagingCount, size: self.itemCount)
                    .asObservable()
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .catch{ error in
                        return .never()
                    }
            }
            .share()
        
       
        Observable.of(searchAction , sortTypeAction)
            .merge()
            .asDriverOnErrorNever()
            .map{ _ in return () }
            .drive(searchClear)
            .disposed(by: disposeBag)
        
       
        
        Observable.of( searchAction.map{ _ in return SortType.accuracy } , input.sortTypeAction.asObservable())
            .merge()
            .asDriverOnErrorNever()
            .drive(sortType)
            .disposed(by: disposeBag)
        

        Observable.of(searchAction , sortTypeAction , infinityScroll)
            .merge()
            .map{ $0.1 }
            .asDriverOnErrorNever()
            .drive(meta)
            .disposed(by: disposeBag)
        
        
        
        searchAction
            .asDriverOnErrorNever()
            .map{ $0.0.sectionModelMake(sectionName: .first) }
            .drive(imageSearchSectionModel)
            .disposed(by: disposeBag)
        
       
        infinityScroll
            .withLatestFrom(mainViewSectionModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .map{ (response , lastSearachModels) -> ImageSearchSectionModel?  in
                guard let searchSection = lastSearachModels.first else { return nil }
                return searchSection.itemsAdd(models: response.0)
            }
            .compactMap{ $0 }
            .asObservable()
        
//            .asObservable()
            .sectionAdd(mainViewSectionModels)
//            .sectionAdd(mainViewSectionModels)
//            .drive(imageSearchSectionModel)
//            .disposed(by: disposeBag)
        
        sortTypeAction
            .map{ $0.0.sectionModelMake(sectionName: .first) }
            .asDriverOnErrorNever()
            .drive(imageSearchSectionModel)
            .disposed(by: disposeBag)
        
      
    
        input.cellClick
            .asObservable()
            .bind { [weak self] imageModel in
                guard let self = self else { return }
                self.builder.coordinator.openDetailView(imageModel)
            }.disposed(by: disposeBag)
 
        
        return .init(
            imageSearchModels: mainViewSectionModels.asDriverOnErrorNever() ,
            searchClear: searchClear.asDriverOnErrorNever(),
            outputError: errorTracker.asDriver(),
            outputActivity : activityIndicator.asDriver(),
            sortType: sortType.asDriverOnErrorNever()
        )
    }
}

extension MainViewModel :  ScrollPagingProtocl{
    
    
    
}


