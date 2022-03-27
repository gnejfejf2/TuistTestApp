//
//  DetailViewCoordinator.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation

class DetailViewCoordinator : BaseCoordinator {
 
    var imageSearchModel : ImageSearchModel?
    
    
    override func start() {
        guard let imageSearchModel = imageSearchModel else { return }
        let viewModel = DetailViewModel(builder: .init(
            coordinator : self ,
            imageSearchModel : imageSearchModel
        ))
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss(){
        
        didFinish(coordinator: self)
    }
    
    
}

