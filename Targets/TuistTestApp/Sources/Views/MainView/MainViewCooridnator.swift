import UIKit
import Swinject
import Domain

protocol MainViewCoorinatorProtocol {
    func openDetailView(_ imageSearchModel : ImageSearchModel)
}


class MainViewCoordinator : Coordinator , MainViewCoorinatorProtocol {
    let navigationController: UINavigationController
    
    
    init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    
 
    func start() {
        let viewModel = Assembler.shared.resolver.resolve(MainViewModel.self , argument : self)!
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func openDetailView(_ imageSearchModel : ImageSearchModel){
        let coordinator = Assembler.shared.resolver.resolve(DetailViewCoordinator.self , arguments : self as Coordinator , imageSearchModel)!
        coordinator.start()
    }
    
}

