//
//  UsecaseAssembler.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Swinject
import UIKit
import NetworkPlatform

class UseCaseAssembly : Assembly {
   
    func assemble(container: Container) {
        container.register(ImageSearchUseCase.self) { (r) in
            let imageSearchUseCase : ImageSearchUseCase = r.resolve(UseCaseProvider.self)!.makeImageSearchUseCase()
            return imageSearchUseCase
        }
    }
}
