//
//  SearchRepository.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/13.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import RxSwift

public protocol ImageSearchInterface {
    func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Single<ImageSearchModels>
}

