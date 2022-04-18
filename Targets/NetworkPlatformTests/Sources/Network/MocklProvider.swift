//
//  MocklProvider.swift
//  NetworkPlatformTests
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation

@testable import NetworkPlatform

final class MockProvider : NetworkProviderInterface {
    
    func makeImageSearchNetwork() -> ImageSearchNetworkInterface {
        let network = MockNetwork()
        return ImageSearchNetwork(network: network)
        
    }
    
}
