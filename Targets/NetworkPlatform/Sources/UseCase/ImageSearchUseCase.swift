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


public final class ImageSearchUseCase : ImageSearchUseCaseInterface{
   
    
    
    private let networkAPI : ImageSearchNetworkInterface
    
    public init(networkAPI : ImageSearchNetworkInterface){
        self.networkAPI = networkAPI
    }
    
    public func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Observable<(ImageSearchModels , PagingAbleModel)> {
        let parameters : ImageSearchRequestModel = ImageSearchRequestModel(query: query, sort: sortType, page: page, size: size)
        
        return networkAPI.fetchImageSearchResponse(parameters : parameters)
            .map{ ($0.documents , $0.meta) }
         
    }
   
}



