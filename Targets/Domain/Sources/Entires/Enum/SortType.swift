//
//  SortType.swift
//  Domain
//
//  Created by 강지윤 on 2022/04/14.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation

public enum SortType : String , Encodable {
    ///정확성
    case accuracy = "accuracy"
    ///최신순
    case recency = "recency"
}
