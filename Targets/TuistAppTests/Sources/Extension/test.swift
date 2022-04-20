//
//  test.swift
//  TuistAppTests
//
//  Created by 강지윤 on 2022/04/19.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import XCTest

class Date_Extension_Test : XCTestCase  {
    
    
    func testDateCal(){
        
        
        
//        let nextTime = Date(timeIntervalSinceNow: <#T##TimeInterval#>)
        
//        nowTime.addTimeInterval(TimeInterval()
        
//        "00:02:54".toDate()
        if("00:02:54".nextTime() < Date()){
            print("시간이지났다")
        }else{
            print("아니다")
        }
        
        print("00:02:54".nextTime())
    }
    
    
}


extension String {
    func nextTime() -> Date { //"yyyy-MM-dd HH:mm:ss"
        let times = self.components(separatedBy: ":").reversed()
        var nextTime : Int = 0
        for (index , stringTime) in times.enumerated() {
            if let time = Int(stringTime) {
                nextTime += time * Int(pow(60.0, Double(index)))
            }
        }
        return Date(timeIntervalSinceNow: TimeInterval(nextTime))
    }
    
}
