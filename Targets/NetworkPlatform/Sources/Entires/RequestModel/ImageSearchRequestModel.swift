//
//  SearchRequestModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation
import Domain

public struct ImageSearchRequestModel : Encodable{
    
    ///검색어
    var query : String
    ///정렬기준
    var sort : SortType
    ///요청하는 페이지 수
    var page : Int
    ///한번에 요청하는 아이템의갯수
    var size : Int
}
