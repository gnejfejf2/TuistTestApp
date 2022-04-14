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
   
    
    
    private let networkAPI : ImageSearchNetwork
    
    public init(networkAPI : ImageSearchNetwork){
        self.networkAPI = networkAPI
    }
    
    public func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Observable<ImageSearchModels> {
        let parameters : ImageSearchRequestModel = ImageSearchRequestModel(query: query, sort: sortType, page: page, size: size)
        
        return networkAPI.fetchImageSearchResponse(parameters : parameters)
                .map{ $0.documents }
        
    }
   
}



