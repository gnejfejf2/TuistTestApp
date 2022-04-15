import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    
    func start()
 
}

protocol ChildCoordinator : AnyObject {
    associatedtype Builder
//    associatedtype ViewModelType
    var baseCoordinator : Coordinator { get }
    
    init(baseCoordinator : Coordinator , builder : Builder)
    
    func start()
    
//    func makeViewModel(builder : Builder) -> ViewModelType
    
    func dismiss()
}

extension ChildCoordinator {
    
    func dismiss(){
        baseCoordinator.navigationController.popViewController(animated: true)
    }
    
}


