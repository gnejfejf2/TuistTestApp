import Alamofire
import Moya
import Foundation


enum NetworkAPI{
    
    case search(parmas : ImageSearchRequestModel)
    
}


extension NetworkAPI : TargetType {
    //BaseURL
    var baseURL: URL {
        switch self {
        default :
            return URL(string: "https://dapi.kakao.com")!
        }
    }
    
    
    var headers: [String: String]? {
        return [
            "accept": "application/json" ,
            "Authorization" : "KakaoAK bc4f662e41a4ba56baa598f8c22efdcd"
        ]
    }
    
    //경로
    var path: String {
        switch self {
        case .search :
            return "/v2/search/image"
        }
    }
    //통신을 get , post , put 등 무엇으로 할지 이곳에서 결정한다 값이 없다면 디폴트로 Get을 요청
    var method : Moya.Method {
        switch self {
        default :
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .search(let parameters) :
            return .requestParameters(parameters: parameters.toDictionary , encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .search(let parmas ) :
            return stubbedResponse("Search\(parmas.sort.rawValue)\(parmas.query)\(parmas.page)")
        default :
            return stubbedResponse("getUserInfo")
        }
    }
    
    
    
    func stubbedResponse(_ filename: String) -> Data! {
        let bundlePath = Bundle.module.path(forResource: "Json", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
    
    
}
