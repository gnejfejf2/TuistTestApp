//
//  UseCase.swift
//  TuistAppTests
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import XCTest

@testable import Domain

class StringExtensionTest: XCTestCase {

    

    func testStringToDate(){
        let dateString = "2020-12-01T18:08:19.000+09:00"
//        dateString.toDate()


        XCTAssert(dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String() == "2020-12-01", dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String())
    }
}
