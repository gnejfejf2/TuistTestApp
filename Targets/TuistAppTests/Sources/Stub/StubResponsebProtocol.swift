//
//  File.swift
//  TuistAppTests
//
//  Created by 강지윤 on 2022/04/19.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation

protocol StubResponsebProtocol {
    
    func stubbedResponse<T : Decodable>(T : T.Type , _ filename: String) throws -> T
    
    
}
extension StubResponsebProtocol{

    func stubbedResponse<T : Decodable>(T : T.Type , _ filename: String) throws -> T {
        do {
//            let t = type(of: self)
//            let bundle = Bundle(for: t.self)
            
            let bundlePath = Bundle(identifier: "com.jyk.TuistAppTests")?.path(forResource: "Json", ofType: "bundle")
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

