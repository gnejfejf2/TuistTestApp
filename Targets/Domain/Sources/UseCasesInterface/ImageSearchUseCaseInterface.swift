//
//  ImageSearchUseCase.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public protocol ImageSearchInterface {
    func imageSearch(query : String , sortType : SortType , page : Int , size : Int) -> Observable<ImageSearchModels>
}

