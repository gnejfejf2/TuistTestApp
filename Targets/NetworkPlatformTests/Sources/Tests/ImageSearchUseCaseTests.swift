//
//  UseCase.swift
//  TuistAppTests
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
import Domain

@testable import NetworkPlatform

class ImageSearchUseCaseTests: XCTestCase {
    
    let imageSearchMockUseCase : ImageSearchMockUseCase = ImageSearchMockUseCase()
    
    class ImageSearchMockUseCase : ImageSearchUseCaseInterface {
        
        func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Observable<(ImageSearchModels , PagingAbleModel)>{
            return Observable.of(([] , PagingAbleModel(isEnd: false, pageableCount: 0, totalCount: 0)))
        }
    }
    
    
    
    func testPerformanceExample() {
        
        let searchItem = imageSearchMockUseCase.imageSearch(query: "", sortType: .accuracy, page: 1, size: 0)
        
        let result = searchItem.toBlocking(timeout: 10)
        
        do{
            let data = try result.first()
            XCTAssertEqual(data?.0.count , 0)
            XCTAssertEqual(data?.1.totalCount, 0)
        } catch{
            XCTFail(error.localizedDescription)
        }
    }
}
