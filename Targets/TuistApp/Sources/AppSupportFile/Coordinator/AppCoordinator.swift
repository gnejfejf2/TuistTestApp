import UIKit
import Swinject

protocol AppCoodinatorProtocol {
    var window : UIWindow { get }
    var navigationController : UINavigationController { get }
    
    
    func start()
}

class AppCoordinator : AppCoodinatorProtocol {
    let window : UIWindow
    let navigationController: UINavigationController
    
    init(window : UIWindow , navigationController : UINavigationController = UINavigationController()){
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
    
        window.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        let coordinator = Assembler.shared.resolver.resolve(MainViewCoordinator.self , argument : navigationController)!
        coordinator.start()
        
    }
    
  
}
