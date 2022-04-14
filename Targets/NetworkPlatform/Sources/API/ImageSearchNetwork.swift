//
//  ImageSearchNetwork.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Domain
import RxSwift

public final class ImageSearchNetwork {
    private let network : Network<ImageSearchResponseModel>

    init(network: Network<ImageSearchResponseModel>) {
        self.network = network
    }

    public func fetchImageSearchResponse(parameters : ImageSearchRequestModel) -> Observable<ImageSearchResponseModel> {
        return network.getItem("/v2/search/image" , parameters: parameters.toDictionary)
//            .map{ $0.documents }
            
    }

//    public func fetchAlbum(albumId: String) -> Observable<Album> {
//        return network.getItem("albums", itemId: albumId)
//    }
}
