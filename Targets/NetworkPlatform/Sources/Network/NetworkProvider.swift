//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Alamofire



final class NetworkProvider {
    private let apiEndpoint : String
    private let header : HTTPHeaders = [
        "accept": "application/json" ,
        "Authorization" : "KakaoAK bc4f662e41a4ba56baa598f8c22efdcd"
    ]
    
    public init() {
        apiEndpoint = "https://dapi.kakao.com"
    }

    func makeImageSearchNetwork() -> ImageSearchNetwork {
        let network = Network<ImageSearchResponseModel>(apiEndpoint, header)
        return ImageSearchNetwork(network: network)
    }

}
