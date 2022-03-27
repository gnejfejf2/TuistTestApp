//
//  ImageSearchModel.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation
import RxDataSources

typealias ImageSearchModels = [ImageSearchModel]

struct ImageSearchModel: Codable , Equatable , IdentifiableType {
    typealias Identity = String
    
    var identity : Identity = UUID().uuidString
    
    let collection, datetime, displaySitename: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
    
    func returnDescription() -> String{
        
        if(self.displaySitename == "" && self.datetime == ""){
            return ""
        }else if(self.displaySitename == "" && self.datetime != ""){
            guard let time = self.datetime.to_ISO_8601_Date()?.to_ISO_8601_Date_String() else { return "" }
            return "문서 작성 시간 \(time)"
        }else if(self.displaySitename != "" && self.datetime == ""){
            return "출처 : \(self.displaySitename)"
        }else{
            guard let time = self.datetime.to_ISO_8601_Date()?.to_ISO_8601_Date_String() else { return "출처 : \(self.displaySitename)" }
            return "출처 : \(self.displaySitename) \n문서 작성 시간 \(time)"
        }
    }
    
}



