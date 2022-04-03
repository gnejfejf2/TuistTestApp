//
//  CoordinatorAssembler.swift
//  TuistTestApp
//
//  Created by 강지윤 on 2022/04/03.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Swinject
import UIKit

class CoordinatorAssembly : Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { (r , window : UIWindow) in
            let appCoordinator = AppCoordinator(window: window)
            return appCoordinator
        }
    }
}
