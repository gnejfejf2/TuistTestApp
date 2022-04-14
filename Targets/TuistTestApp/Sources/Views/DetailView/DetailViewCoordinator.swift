//
//  DetailViewCoordinator.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation



import Domain
class DetailViewCoordinator : ChildCoordinator {

    struct Builder {
        let imageSearchModel : ImageSearchModel
    }
    
   
    var baseCoordinator : Coordinator
    var builder : Builder
    
    
    required init(baseCoordinator: Coordinator , builder : Builder) {
        self.baseCoordinator = baseCoordinator
        self.builder = builder
    }
    
    
    func start() {
//        let viewModel = makeViewModel(builder : builder)
//        let viewController = DetailViewController(viewModel: viewModel)
//        baseCoordinator.navigationController.pushViewController(viewController, animated: true)
    }
    
    
//    func makeViewModel(builder : Builder) -> DetailViewModel{
//
//
//
//        return DetailViewModel(networkAPI: NetworkServiceProtocol , builder: .init(coordinator: self, imageSearchModel: <#T##ImageSearchModel#>))
//    }
        

    
    
}

