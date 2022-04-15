//
//  Encodable_Extension.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/13.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
extension Encodable {
    var toDictionary : [String: Any] {
        guard let object = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return [:] }
        return dictionary
    }
}
