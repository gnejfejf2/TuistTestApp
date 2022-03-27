import RxMoya
import Moya
import Alamofire
import RxSwift

protocol NetworkServiceProtocol {
    
    //네트워크 프로바이더
    var provider : MoyaProvider<NetworkAPI> { get }
    //데이터요청
    func request<T: Decodable>(type : T.Type , _ api: NetworkAPI) -> Single<T>
    func requestSimple(_ api: NetworkAPI) -> Single<Response>

}

final class NetworkingAPI: NetworkServiceProtocol {
    static let shared : NetworkingAPI = NetworkingAPI()
    
    
    
    let provider: MoyaProvider<NetworkAPI>
    
    //provider 객체 삽입
    init(provider : MoyaProvider<NetworkAPI> = MoyaProvider<NetworkAPI>()) {
        self.provider = provider
    }
   
  
    //데이터통신코드
    func request<T: Decodable>(type : T.Type , _ api: NetworkAPI) -> Single<T> {
        return provider.rx
            .request(api)
            .filterSuccessfulStatusCodes()
            .map( T.self )
           
    }
    
    //데이터통신코드
    //따로 데이터변환이 필요하지않고 StatusCode로 값을 결과를 구분할 경우 사용 ex delete , add 등
    func requestSimple(_ api: NetworkAPI) -> Single<Response> {
        return provider.rx
            .request(api)
            .filterSuccessfulStatusCodes()
    }
}
