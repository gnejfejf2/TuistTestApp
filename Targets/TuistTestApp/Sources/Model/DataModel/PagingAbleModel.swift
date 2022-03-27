//
//  PagingAbleModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation
// MARK: - Meta
struct PagingAbleModel: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
