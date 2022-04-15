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
            .subscribe { (sectionModel , sectionModels)  in
                mainViewSectionModels.onNext(sectionModels.itemChange(items: sectionModel, index: 0))
            }
            .disposed(by: disposeBag)

        
        
  //코드 A
        let searchAction = input.searchAction
            .asObservable()
            .flatMap { [weak self] keyword -> Observable<(ImageSearchModels , PagingAbleModel)> in
                guard let self = self else { return .never() }
                self.pagingCountClear()
                return self.imageSearchUseCase.imageSearch(query: keyword, sortType: .accuracy, page: self.pagingCount, size: self.itemCount)
                    .asObservable()
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .catch{ error in
                        return .never()
                    }
            }
            .share()

        searchAction
            .asDriverOnErrorNever()
            .map{ _ in return () }
            .drive(searchClear)
            .disposed(by: disposeBag)

        searchAction
            .asDriverOnErrorNever()
            .map{ _ in return SortType.accuracy }
            .drive(sortType)
            .disposed(by: disposeBag)

        searchAction
            .asDriverOnErrorNever()
            .map{ $0.1 }
            .drive(meta)
            .disposed(by: disposeBag)

        searchAction
            .asDriverOnErrorNever()
            .map{ $0.0.sectionModelMake(sectionName: "첫번째") }
            .drive(imageSearchSectionModel)
            .disposed(by: disposeBag)
        
        
        input.searchAction
            .asObservable()
            .flatMap { [weak self] keyword -> Observable<(ImageSearchModels , PagingAbleModel)> in
                guard let self = self else { return .never() }
                self.pagingCountClear()
                return self.imageSearchUseCase.imageSearch(query: keyword, sortType: .accuracy, page: self.pagingCount, size: self.itemCount)
                    .asObservable()
                    .trackActivity(self.activityIndicator)
                    .trackError(self.errorTracker)
                    .catch{ error in
                        return .never()
                    }
            }
            .asDriverOnErrorNever()
            .drive(onNext: { response  in
                searchClear.onNext(())
                sortType.onNext(SortType.accuracy)
                meta.onNext(response.1)
                imageSearchSectionModel.onNext(response.0.sectionModelMake(sectionName: "첫번째"))
            })
            .disposed(by: disposeBag)
        
       
        
        
        
        
        
        
        input.sortTypeAction
            .asObservable()
            .subscribe(sortType)
            .disposed(by: disposeBag)
//        
        input.bottomScrollTriger
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
            .withLatestFrom(mainViewSectionModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .map{ (response , lastSearachModels) -> ImageSearchSectionModel?  in
                guard let searchSection = lastSearachModels.first else { return nil }
                return searchSection.itemsAdd(models: response.0)
            }
            .compactMap{ $0 }
            .drive(imageSearchSectionModel)
            .disposed(by: disposeBag)



        input.cellClick
            .asObservable()
            .bind { [weak self] imageModel in
                guard let self = self else { return }
                self.builder.coordinator.openDetailView(imageModel)
            }.disposed(by: disposeBag)
//        
        mainViewSectionModels
            .asObservable()
            .withLatestFrom(meta) { ($0 , $1) }
            .map { [weak self] data in
                guard let self = self else { return false }
                return self.pagingAbleChecking(paingAble: data.1, totalCount:  data.0.first!.items.count)
            }
            .subscribe(scrollPagingCall)
            .disposed(by: disposeBag)
//
        input.sortTypeAction
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
            .withLatestFrom(mainViewSectionModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .drive(onNext: { response , lastSearachModels in
                let searchModels = response.0
                let metaModel = response.1
                searchClear.onNext(())
                meta.onNext(metaModel)
                var lastItem = lastSearachModels
                lastItem[0].items = searchModels
                mainViewSectionModels.onNext(lastItem)
            })
            .disposed(by: disposeBag)

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


