import UIKit
import NetworkPlatform



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

        let viewModel = MainViewModel(imageSearchUseCase: ImageSearchUseCase(networkAPI : NetworkingAPI.shared), builder: .init(coordinator: self))
        let viewController = MainViewController(viewModel: viewModel)
       
        navigationController.pushViewController(viewController, animated: true)
//        
    }
    
    
    func openDetailView(_ imageSearchModel : ImageSearchModel){
//        let coordinator = DetailViewCoordinator(navigationController : navigationController)
//        coordinator.imageSearchModel = imageSearchModel
//        coordinator.start()
    }
    
}

