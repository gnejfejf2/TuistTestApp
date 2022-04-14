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

class ViewModelAssembler : Assembly {
    func assemble(container: Container) {
        container.register(MainViewModel.self) { (r , imageSearchUseCase : ImageSearchUseCase) in
            let mainViewModel : MainViewModel = MainViewModel(imageSearchUseCase: imageSearchUseCase, builder: .init(coordinator: r.resolve(MainViewCoordinator.self)!))
            return mainViewModel
        }
    }
}
