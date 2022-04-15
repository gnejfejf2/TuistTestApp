//
//  ImageSearchSectionModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/19.
//

import RxDataSources
import Foundation
import Domain

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
    func itemsAdd(models : ImageSearchModels) -> ImageSearchSectionModel {
        return ImageSearchSectionModel(name: self.name, items: self.items + models)
    }
}


typealias ImageSearchSectionModels = [ImageSearchSectionModel]


extension ImageSearchSectionModels {
    
    func itemChange(items : ImageSearchSectionModel , index : Int) -> [ImageSearchSectionModel]{
        var original = self
        if(self.count >  index){
            original[index] = items
        }else{
            original.insert(items, at: index)
        }
        return original
    }
    
}
