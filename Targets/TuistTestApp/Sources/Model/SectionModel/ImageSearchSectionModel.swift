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

//Domain에 RxSwiftDataSource 의존성을 없애기위해 여기서 Extension해서 확장해서 사용
extension ImageSearchModel : IdentifiableType{
    public var identity: String {
        UUID().uuidString
    }
    public typealias Identity = String
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
