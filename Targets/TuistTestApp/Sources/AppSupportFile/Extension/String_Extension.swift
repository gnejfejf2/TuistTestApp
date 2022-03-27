//
//  String_Extension.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation

extension String{
    
    func to_ISO_8601_Date() -> Date?{
        let dateFormatter = DateFormatter()
//        "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
       
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    
    
    
}
extension Date {
    func to_ISO_8601_Date_String() -> String{
        let date = self

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.string(from: date)
        
        return dateFormatter.string(from: date)
    }
}
