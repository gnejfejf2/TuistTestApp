//
//  CoordinatorAssembler.swift
//  TuistTestApp
//
//  Created by 강지윤 on 2022/04/03.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Swinject
import Domain
import UIKit

class CoordinatorAssembly : Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { (r , window : UIWindow) in
            let appCoordinator = AppCoordinator(window: window)
            return appCoordinator
        }
        container.register(MainViewCoordinator.self) { (r , navigationController : UINavigationController) in
            let mainViewCoordinator = MainViewCoordinator(navigationController: navigationController)
            return mainViewCoordinator
        }
        //코디네이터를 변수로 받는이유는 베이스가 되는 코디네이터가 누가 될지 모르기에
        //마스터 코디네이터를 변수로 받는다.
        container.register(DetailViewCoordinator.self) { (r , coordinator : Coordinator , imageSearchModel : ImageSearchModel ) in
            let detailViewCoordinator : DetailViewCoordinator = DetailViewCoordinator(baseCoordinator: coordinator, builder: .init(imageSearchModel: imageSearchModel))
            return detailViewCoordinator
        }
    }
}
