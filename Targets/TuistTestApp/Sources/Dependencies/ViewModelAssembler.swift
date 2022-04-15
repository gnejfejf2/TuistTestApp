//
//  File.swift
//  TuistTest
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Swinject
import NetworkPlatform
import UIKit

class ViewModelAssembler : Assembly {
    func assemble(container: Container) {
        container.register(MainViewModel.self) { (r , coordinator : MainViewCoordinator) in
            let imageSearchUseCase : ImageSearchUseCaseInterface = r.resolve(ImageSearchUseCaseInterface.self)!
            let mainViewModel : MainViewModel = MainViewModel(imageSearchUseCase : imageSearchUseCase, builder: .init(coordinator: coordinator))
            return mainViewModel
        }
    }
}
