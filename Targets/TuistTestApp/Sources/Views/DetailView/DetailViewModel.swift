//
//  DetailViewModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class DetailViewModel : ViewModelBuilderProtocol {
   
    
   
    
    
    struct Input {
        let exitAction : Driver<Void>
    }
    
    struct Output {
        let imageSearchModel : Driver<ImageSearchModel>
    }
    
    struct Builder {
        let coordinator : DetailViewCoordinator
        let imageSearchModel : ImageSearchModel
    }
    
    
    let errorTracker = ErrorTracker()
    
   
    let networkAPI : NetworkServiceProtocol
    let builder : Builder
    let disposeBag : DisposeBag = DisposeBag()


    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder : Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    
    
    func transform(input: Input) -> Output {
        let imageSearchModel = BehaviorSubject<ImageSearchModel>(value: builder.imageSearchModel)
        
        input.exitAction
            .asObservable()
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.builder.coordinator.dismiss()
            }
            .disposed(by: disposeBag)
        
        
            
        return .init(imageSearchModel: imageSearchModel.asDriverOnErrorNever())
    }

}
