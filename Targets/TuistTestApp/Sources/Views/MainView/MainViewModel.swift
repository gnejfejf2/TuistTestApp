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

class MainViewModel : ViewModelBuilderProtocol {
   
    
    
    struct Input {
        let searchAction : Driver<String>
        let bottomScrollTriger : Driver<Void>
        let cellClick : Driver<ImageSearchModel>
        let sortTypeAction : Driver<ImageSearchRequestModel.SortType>
    }
    
    struct Output {
        let imageSearchModels : Driver<[ImageSearchSectionModel]>
        let searchClear : Driver<Void>
        let outputError : Driver<Error>
        let outputActivity : Driver<Bool>
        let sortType : Driver<ImageSearchRequestModel.SortType>
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
    
    let networkAPI : NetworkServiceProtocol
    let builder : Builder
    let disposeBag : DisposeBag = DisposeBag()
    
    required init( networkAPI : NetworkServiceProtocol = NetworkingAPI.shared  , builder : Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        let imageSearchModels = BehaviorSubject<[ImageSearchSectionModel]>(value: [ImageSearchSectionModel(name: "첫번째", items: [])])
        let searchClear = PublishSubject<Void>()
        let meta = PublishSubject<PagingAbleModel>()
        let scrollPagingCall = PublishSubject<Bool>()
        let sortType = PublishSubject<ImageSearchRequestModel.SortType>()
        
        input.searchAction
            .asObservable()
            .flatMap { [weak self] keyword -> Observable<ImageSearchResponseModel>  in
                guard let self = self else { return .never() }
                self.pagingCountClear()
                return self.getImageSearchModels(param: ImageSearchRequestModel(query: keyword, sort: .accuracy, page: self.pagingCount, size: self.itemCount), networkAPI: self.networkAPI)
                    .trackError(self.errorTracker)
                    .catch{ error in
                         return .never()
                    }
            }
            .withLatestFrom(imageSearchModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .drive(onNext: { response , lastSearachModels in
                let searchModels = response.documents
                let metaModel = response.meta
                sortType.onNext(ImageSearchRequestModel.SortType.accuracy)
                searchClear.onNext(())
                meta.onNext(metaModel)
                var lastItem = lastSearachModels
                lastItem[0].items = searchModels
                imageSearchModels.onNext(lastItem)
            })
            .disposed(by: disposeBag)
        
       
        
        
        
        
        
        
        input.sortTypeAction
            .asObservable()
            .subscribe(sortType)
            .disposed(by: disposeBag)
        
        input.bottomScrollTriger
            .asObservable()
            .withLatestFrom(scrollPagingCall) { $1 }
            .filter{ $0 }
            .withLatestFrom(Observable.combineLatest(input.searchAction.asObservable() , sortType)) { ($1.0 , $1.1) }
            .flatMap{ [weak self] keyword , sortType  -> Observable<ImageSearchResponseModel> in
                guard let self = self else { return .never() }
                let param = ImageSearchRequestModel(query: keyword, sort: sortType, page: self.pagingCount, size: self.itemCount)
                return self.getImageSearchModels(param: param, networkAPI: self.networkAPI)
                                   .trackError(self.errorTracker)
                                   .catch{ error in
                                        return .never()
                                   }
            }
            .withLatestFrom(imageSearchModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .drive(onNext: { response , lastSearachModels in
                let searchModels = response.documents
                let metaModel = response.meta
                meta.onNext(metaModel)
                var lastItem = lastSearachModels
                lastItem[0].items += searchModels
                imageSearchModels.onNext(lastItem)
            })
            .disposed(by: disposeBag)

        
        input.cellClick
            .asObservable()
            .bind { [weak self] imageModel in
                guard let self = self else { return }
                self.builder.coordinator.openDetailView(imageModel)
            }.disposed(by: disposeBag)
        
        imageSearchModels
            .asObservable()
            .withLatestFrom(meta) { ($0 , $1) }
            .map { [weak self] data in
                guard let self = self else { return false }
                return self.pagingAbleChecking(paingAble: data.1, totalCount:  data.0.first!.items.count)
            }
            .subscribe(scrollPagingCall)
            .disposed(by: disposeBag)

        input.sortTypeAction
            .asObservable()
            .withLatestFrom(input.searchAction) { ($1 , $0) }
            .flatMap { [weak self] keyword , sortType -> Observable<ImageSearchResponseModel>  in
                guard let self = self else { return .never() }
                self.pagingCountClear()
                return self.getImageSearchModels(param: ImageSearchRequestModel(query: keyword, sort: sortType, page: self.pagingCount, size: self.itemCount), networkAPI: self.networkAPI)
                    .trackError(self.errorTracker)
                    .trackActivity(self.activityIndicator)
                    .catch{ error in
                         return .never()
                    }
            }
            .withLatestFrom(imageSearchModels) { ($0 , $1) }
            .asDriverOnErrorNever()
            .drive(onNext: { response , lastSearachModels in
                let searchModels = response.documents
                let metaModel = response.meta
                searchClear.onNext(())
                meta.onNext(metaModel)
                var lastItem = lastSearachModels
                lastItem[0].items = searchModels
//                print(lastSearachModels)
                imageSearchModels.onNext(lastItem)
            })
            .disposed(by: disposeBag)
        
        
        
        
        return .init(
            imageSearchModels: imageSearchModels.asDriverOnErrorNever() ,
            searchClear: searchClear.asDriverOnErrorNever(),
            outputError: errorTracker.asDriver(),
            outputActivity : activityIndicator.asDriver(),
            sortType: sortType.asDriverOnErrorNever()
        )
    }
}

extension MainViewModel : SearchDataProtocol , ScrollPagingProtocl{
    
    
    
}


