//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: UseCaseProviderInterface {
    
    
    private let networkProvider: NetworkProvider

    public init(networkProvider : NetworkProvider = NetworkProvider()) {
        self.networkProvider = NetworkProvider()
    }

    public func makeImageSearchUseCase() -> ImageSearchUseCaseInterface {
        return ImageSearchUseCase(networkAPI: networkProvider.makeImageSearchNetwork())
    }
  
}
