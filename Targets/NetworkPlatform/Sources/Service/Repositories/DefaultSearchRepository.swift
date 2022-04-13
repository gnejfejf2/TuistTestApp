//
//  SearchRepository.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/13.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import RxSwift


final class DefaultSearchRepository {
    
    private let networkAPI : NetworkServiceProtocol
    
    init(networkAPI : NetworkServiceProtocol){
        self.networkAPI = networkAPI
    }

}



extension DefaultSearchRepository {
    func getImageSearchModels(param : ImageSearchRequestModel , networkAPI : NetworkServiceProtocol) -> Single<ImageSearchResponseModel> {
        networkAPI.request(type: ImageSearchResponseModel.self, .search(parmas: param))
    }
}
