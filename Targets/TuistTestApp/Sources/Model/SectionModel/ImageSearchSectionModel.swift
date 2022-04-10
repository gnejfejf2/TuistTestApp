//
//  ImageSearchSectionModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/19.
//

import RxDataSources

struct ImageSearchSectionModel {
    let name : String
    var items : ImageSearchModels
}

extension ImageSearchSectionModel : AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = ImageSearchModel
    
    var identity: String {
        return name
    }
    
    
    init(original: ImageSearchSectionModel , items: ImageSearchModels) {
        self = original
        self.items = items
    }
}
