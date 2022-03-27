import UIKit

class AppCoordinator : BaseCoordinator {
    private let window : UIWindow
    
    init(window : UIWindow){
        self.window = window
        super.init(navigationController : UINavigationController())
    }
    
    override func start() {
        window.makeKeyAndVisible()
        
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        
        let coordinator = MainViewCoordinator(navigationController: navigationController)
        
        coordinator.start()
        
        
    }
    
  
}
