//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
public protocol UseCaseProviderInterface {
    
    func makeImageSearchUseCase() -> ImageSearchUseCaseInterface
}
