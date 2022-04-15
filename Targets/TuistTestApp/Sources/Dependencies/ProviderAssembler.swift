//
//  ProviderAssembler.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Swinject
import NetworkPlatform

class ProviderAssembler : Assembly {
    func assemble(container: Container) {
        container.register(UseCaseProvider.self) { (r) in
            let useCaseProvider = UseCaseProvider()
            return useCaseProvider
        }
       
    }
}
