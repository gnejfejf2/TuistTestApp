//
//  ImageSearchMock.swift
//  Domain
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import RxSwift



class ImageSearchMock : ImageSearchUseCaseInterface , StubResponsebProtocol{
    func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Observable<(ImageSearchModels , PagingAbleModel)>{
        let filePath : String = "Search\(sortType)\(query)\(page)"
        print(filePath)
         do{
            let data : ImageSearchResponseModel = try stubbedResponse(T : ImageSearchResponseModel.self , filePath)
            return Observable.of(data)
                .map{ ($0.documents , $0.meta) }
                .catch { error in
                    throw error
                }
        }catch{
            return .error(error)
        }
    }
}
