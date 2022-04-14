//
//  Network.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {
    
    private let endPoint: String
    private let header : HTTPHeaders
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String , _ header : HTTPHeaders) {
        self.endPoint = endPoint
        self.header = header
        //백그라운드 스레드 지정
        //디스패치큐를(GCD) 이용해 병렬비동기 쓰레드의 스케줄러를 만든다.
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    
    func getItem(_ path: String , parameters : [String: Any] = [:]) -> Observable<T> {
        let absolutePath = "\(endPoint)\(path)"
        print(parameters)
        print(absolutePath)
        return RxAlamofire
            .data(.get, absolutePath , parameters: parameters , encoding: URLEncoding.queryString, headers: header)
        
            .debug()
            .observe(on: scheduler)
            .map({ data -> T in
                print(String(data: data, encoding: .utf8))
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
    
    func postItem(_ path: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
    
    func updateItem(_ path: String, itemId: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
    
    func deleteItem(_ path: String, itemId: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.delete, absolutePath)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
}
