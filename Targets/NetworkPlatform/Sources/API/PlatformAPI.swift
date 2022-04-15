//
//  PlatformAPI.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Alamofire
import Moya
import Foundation

public enum PlatformAPI{
    
    case search(parmas : ImageSearchRequestModel)
    
}


 extension PlatformAPI : TargetType {
    //BaseURL
     public var baseURL: URL {
        switch self {
        default :
            return URL(string: "https://dapi.kakao.com")!
        }
    }
    
    
     public var headers: [String: String]? {
        return [
            "accept": "application/json" ,
            "Authorization" : "KakaoAK bc4f662e41a4ba56baa598f8c22efdcd"
        ]
    }
    
    //경로
     public var path: String {
        switch self {
        case .search :
            return "/v2/search/image"
        }
    }
    //통신을 get , post , put 등 무엇으로 할지 이곳에서 결정한다 값이 없다면 디폴트로 Get을 요청
     public var method : Moya.Method {
        switch self {
        default :
            return .get
        }
    }
    
     public var task: Task {
        switch self {
        case .search(let parameters) :
            return .requestParameters(parameters: parameters.toDictionary , encoding: URLEncoding.queryString)
        }
    }
     public var sampleData: Data {
        switch self {
        case .search(let parmas ) :
            return stubbedResponse("Search\(parmas.sort.rawValue)\(parmas.query)\(parmas.page)")
        default :
            return stubbedResponse("getUserInfo")
        }
    }
    
    
    
    private func stubbedResponse(_ filename: String) -> Data! {
        let bundlePath = Bundle.main.path(forResource: "Json", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
