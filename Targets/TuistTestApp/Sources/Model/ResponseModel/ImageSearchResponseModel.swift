//
//  SearchResponseModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation



struct ImageSearchResponseModel : Decodable{
    let documents : ImageSearchModels
    let meta: PagingAbleModel
}




