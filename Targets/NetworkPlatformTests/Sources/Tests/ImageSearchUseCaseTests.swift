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
           
            do{
                let data : ImageSearchResponseModel = try stubbedResponse(T : ImageSearchResponseModel.self , "Search\(sortType)\(query)\(page)")
                return Observable.of(data)
                    .map{ ($0.documents , $0.meta) }
                    .catch { error in
                        throw error
                    }
            }catch{
                return .error(error)
            }
        }
        
        private func stubbedResponse<T : Decodable>(T : T.Type , _ filename: String) throws -> T {
            do {
                let bundlePath = Bundle(identifier: "com.jyk.NetworkPlatformTests")?.path(forResource: "Json", ofType: "bundle")
                guard let bundlePath = bundlePath else { throw StubError.bundlePathNil }
                
                let bundle = Bundle(path: bundlePath)
                
                guard let bundle = bundle else { throw StubError.bundleNil }
                
                let path = bundle.path(forResource: filename, ofType: "json")
                guard let path = path else { throw StubError.pathNil }
               
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let item = try JSONDecoder().decode(T.self, from: data)
                
                
                return item
            }catch{
                throw error
            }
        }
        
        
    }
    

    
    func testPerformanceExample() {
     
        let searchItem = imageSearchMockUseCase.imageSearch(query: "강지윤강지", sortType: .accuracy, page: 1, size: 0)
        
        let result = searchItem.toBlocking(timeout: 10)
        
        do{
            let data = try result.first()
            XCTAssertEqual(data?.0.count , 10)
            XCTAssertEqual(data?.1.totalCount, 12)
        } catch{
            XCTFail(error.localizedDescription)
        }
    }
}


