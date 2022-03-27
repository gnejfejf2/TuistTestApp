//
//  StringExtensionTest.swift
//  BrandiAppTests
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation


import XCTest


@testable import TuistTestApp

class StringExtensionTest: XCTestCase {
    
    // MARK: - GIVEN
    override func setUp() {
       
        
    }
    
    
    func testStringToDate(){
        let dateString = "2020-12-01T18:08:19.000+09:00"
//        dateString.toDate()
       
        
        XCTAssert(dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String() == "2020-12-01", dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String())
    }
}
