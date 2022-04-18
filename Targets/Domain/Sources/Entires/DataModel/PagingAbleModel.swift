//
//  PagingAbleModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

// MARK: - Meta
public struct PagingAbleModel: Codable {
    public let isEnd: Bool
    public let pageableCount, totalCount: Int

    public init(isEnd : Bool , pageableCount : Int , totalCount : Int){
        self.isEnd = isEnd
        self.pageableCount = pageableCount
        self.totalCount = totalCount
    }
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
