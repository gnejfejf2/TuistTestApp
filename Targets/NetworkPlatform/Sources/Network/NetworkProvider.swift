//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Alamofire


public protocol NetworkProviderInterface {
    
    
    
    func makeImageSearchNetwork() -> ImageSearchNetworkInterface
}



public final class NetworkProvider : NetworkProviderInterface {
    private let apiEndpoint : String = "https://dapi.kakao.com"
    private let header : HTTPHeaders = [
        "accept": "application/json" ,
        "Authorization" : "KakaoAK bc4f662e41a4ba56baa598f8c22efdcd"
    ]
    
    

    public func makeImageSearchNetwork() -> ImageSearchNetworkInterface {
        let network = Network<ImageSearchResponseModel>(apiEndpoint, header)
        return ImageSearchNetwork(network: network)
    }

}
