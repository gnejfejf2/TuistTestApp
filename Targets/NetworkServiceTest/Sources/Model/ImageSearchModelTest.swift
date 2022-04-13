////
////  ImageSearchModelTest.swift
////  BrandiAppTests
////
////  Created by 강지윤 on 2022/03/20.
////
//
//import XCTest
//
//
//@testable import TuistTestApp
//
//class ImageSearchModelTest: XCTestCase {
//    
//   
//    
//    
//    func test_returnDescription_datetime_displaySitename(){
//        let imageSearchModel = ImageSearchModel(collection: "", datetime: "2020-12-01T18:08:19.000+09:00", displaySitename: "뉴스", docURL: "", height: 1, imageURL: "", thumbnailURL: "", width: 1)
////        dateString.toDate()
//       
//        
//        XCTAssert(imageSearchModel.returnDescription() == "출처 : 뉴스 \n문서 작성 시간 2020-12-01" , imageSearchModel.returnDescription())
//    }
//    
//    func test_returnDescription_datetime(){
//        let imageSearchModel = ImageSearchModel(collection: "", datetime: "2020-12-01T18:08:19.000+09:00", displaySitename: "", docURL: "", height: 1, imageURL: "", thumbnailURL: "", width: 1)
////        dateString.toDate()
//       
//        
//        XCTAssert(imageSearchModel.returnDescription() == "문서 작성 시간 2020-12-01" , imageSearchModel.returnDescription())
//    }
//    
//    func test_returnDescription_displaySitename(){
//        let imageSearchModel = ImageSearchModel(collection: "", datetime: "", displaySitename: "뉴스", docURL: "", height: 1, imageURL: "", thumbnailURL: "", width: 1)
////        dateString.toDate()
//       
//        
//        XCTAssert(imageSearchModel.returnDescription() == "출처 : 뉴스" , imageSearchModel.returnDescription())
//    }
//    func test_returnDescription_none(){
//        let imageSearchModel = ImageSearchModel(collection: "", datetime: "", displaySitename: "", docURL: "", height: 1, imageURL: "", thumbnailURL: "", width: 1)
////        dateString.toDate()
//       
//        
//        XCTAssert(imageSearchModel.returnDescription() == "" , imageSearchModel.returnDescription())
//    }
//}
