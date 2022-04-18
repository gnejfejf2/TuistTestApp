//
//  ImageSearchNetwork.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Domain
import RxSwift


public protocol ImageSearchNetworkInterface {
    
    func fetchImageSearchResponse(parameters : ImageSearchRequestModel) -> Observable<ImageSearchResponseModel>
    
}

public final class ImageSearchNetwork : ImageSearchNetworkInterface {
    private let network : NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    public func fetchImageSearchResponse(parameters : ImageSearchRequestModel) -> Observable<ImageSearchResponseModel> {
        return network.getItem(ImageSearchResponseModel.self , "/v2/search/image" , parameters: parameters.toDictionary)
    }

}
