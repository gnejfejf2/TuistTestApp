//
//  StubError.swift
//  TuistAppTests
//
//  Created by 강지윤 on 2022/04/19.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation


enum StubError : Error{
    case bundlePathNil
    case bundleNil
    case pathNil
    
    
}

extension StubError: LocalizedError {
    
    
    public var errorDescription: String? {
        switch self {
        case .bundlePathNil: return "번들 경로 오류"
        case .bundleNil: return "번들 오류"
        case .pathNil: return "파일명 오류"
        }
    }
}
