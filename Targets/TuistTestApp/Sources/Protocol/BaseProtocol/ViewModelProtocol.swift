import Foundation
import RxSwift

//Builder를 이용하여 이전의 코디네이터에서 받아오는 데이터를 추상화 작업을 처리하고
//사용할때는 빌더에서 꺼내서 사용한다. or 빌더에서 꺼내서 데이터를 넣어줘도된다 뭐가 좋은지는 모르겠네
//기타 값이 필요한경우 disposebag 아래에 작성한다.
//let networkAPI : NetworkingAPI
//let disposeBag = DisposeBag()
//let repo : Repo
protocol ViewModelBuilderProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Builder
    var networkAPI : NetworkServiceProtocol { get }
    var builder : Builder { get }
    var disposeBag : DisposeBag { get }
    
    init(networkAPI : NetworkServiceProtocol , builder : Builder)
    
    func transform(input: Input) -> Output
   
}
