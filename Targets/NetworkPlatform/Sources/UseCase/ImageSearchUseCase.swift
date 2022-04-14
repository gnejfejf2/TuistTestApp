//
//  SearchRepository.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/13.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Domain
import RxSwift


public final class ImageSearchUseCase : ImageSearchInterface{
   
    
    
    private let networkAPI : NetworkServiceProtocol
    
    public init(networkAPI : NetworkServiceProtocol){
        self.networkAPI = networkAPI
    }
    
    public func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Single<ImageSearchModels> {
        let param : ImageSearchRequestModel = ImageSearchRequestModel(query: query, sort: sortType, page: page, size: size)
        
        return networkAPI.request(type: ImageSearchResponseModel.self, .search(parmas: param))
                .map{ $0.documents }
    }
   
}



