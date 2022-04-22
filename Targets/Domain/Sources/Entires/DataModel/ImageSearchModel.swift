import Foundation


public typealias ImageSearchModels = [ImageSearchModel]

public struct ImageSearchModel: Codable , Equatable   {
    
    public let collection, datetime, displaySitename: String
    public let docURL: String
    public let height: Int
    public let imageURL: String
    public let thumbnailURL: String
    public let width: Int

    enum CodingKeys: String, CodingKey {
        case collection, datetime
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
    
    public func returnDescription() -> String{
        
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



