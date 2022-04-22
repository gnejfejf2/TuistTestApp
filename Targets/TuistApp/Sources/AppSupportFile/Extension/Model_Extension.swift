//
//  Model_Extension.swift
//  Domain
//
//  Created by 강지윤 on 2022/04/15.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import RxDataSources
import Domain

extension ImageSearchModels {
    enum SectionName : String{
        case first = "첫번째"
        
    }
    
    
    
    func sectionModelMake(sectionName : SectionName) -> ImageSearchSectionModel {
        return ImageSearchSectionModel(name: sectionName.rawValue, items: self)
    }
}

//Domain에 RxSwiftDataSource 의존성을 없애기위해 여기서 Extension해서 확장해서 사용
extension ImageSearchModel : IdentifiableType{
    public var identity: String {
        UUID().uuidString
    }
    public typealias Identity = String
}
