//
//  MockNetwork.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import RxSwift

@testable import NetworkPlatform

final class MockNetwork : NetworkProtocol {
    func getItem<T>(_ type: T.Type, _ path: String, parameters: [String : Any]) -> Observable<T> where T : Decodable {
        do{
            var fileName : String = path
            for parameter in parameters{
                fileName += "\(parameter.value)"
            }
            let data : T = try stubbedResponse(T : T.self , fileName)
            
            return Observable.of(data)
        }catch{
            return .never()
        }
       
    }
    
    func postItem<T>(_ type: T.Type, _ path: String, parameters: [String : Any]) ->  Observable<T> where T : Decodable {
        do{
            let fileName : String = path
            let data : T = try stubbedResponse(T : T.self , fileName)
            
            return Observable.of(data)
        }catch{
            return .never()
        }
       
    }
    
    func updateItem<T>(_ type: T.Type, _ path: String, itemId: String, parameters: [String : Any]) -> Observable<T> where T : Decodable {
        do{
            let fileName : String = path
            let data : T = try stubbedResponse(T : T.self , fileName)
            
            return Observable.of(data)
        }catch{
            return .never()
        }
       
    }
    
    func deleteItem<T>(_ type: T.Type, _ path: String, itemId: String) -> Observable<T> where T : Decodable {
        do{
            let fileName : String = path
            let data : T = try stubbedResponse(T : T.self , fileName)
            
            return Observable.of(data)
        }catch{
            return .never()
        }
       
    }
    
    
  
    
    
    private func stubbedResponse<T : Decodable>(T : T.Type , _ filename: String) throws -> T {
        do {
            let bundlePath = Bundle(identifier: "com.jyk.NetworkPlatformTests")!.path(forResource: "Json", ofType: "bundle")
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

