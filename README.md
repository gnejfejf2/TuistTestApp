# 2년차 주니어 개발자의 Tusit , Swinject , Clean Architecture 공부용 프로젝트

개인적으로 궁금했던 것들을 한곳으로 모아 공부한 자료입니다.
아직 부족한점이 많은 프로젝트입니다.
Domain , NetworkPlatform을 무엇인지 정의를 해야하는데 아직 xcode에서 static library , dynamic library , library 의 동작방식의 정확한 차이점을 몰라 공부중에 있습니다.



Architecture : Clean Architecture and MVVM - Coordinator 
참고자료
1. https://github.com/kudoleh/iOS-Clean-Architecture-MVVM
2. https://github.com/sergdort/CleanArchitectureRxSwift

프로젝트 생성 도구 : Tuist
https://github.com/tuist/tuist

사용한 라이브러리

네트워크 
Alamofire , RxAlamofire , Kingfisher
UI 
SnapKit , Then
Reactive Programing
RxSwift , RxDataSources , RxGesture



실행방법

tuist 버전은 3.x 입니다.

1.Tuist 설치
->curl -Ls https://install.tuist.io | bash
2.서드파티 패치
-> tuist fetch
3.튜이스트생성
-> tuist generate


소개

Domain :

Clean Architecture 가장 내부에 존재

App에서 사용되는 전체적인 Entires , UseCase Protocol으로 이루어짐





NetworkPlatform :

Clean Architecture Domain 바로 외부에 존재

API : Usecase에서 요청하는 데이터를 리턴하는 Class 집단
Entires : 서버에 API를 요청할때 사용할 RequestModel 과 응답값으로 사용할 ResponseModel로 구성
Network : Network 직접적으로 서버와 데이터 통신을 하는 클래스 Generic을 이용하여 리턴값을 Generic하게 구성
          NetworkProvider Network를 Make하는 Class 여기서 Network에서 사용할 Header, Endpoint등을 구성하여 변수로 넘겨준다.(의존성 주입)
          데이터 제공자가 변경이된다면 이쪽을 추가 or 변경하는 작업이 필요함
          UseCase : 실제 ViewModel에 넘겨 사용하는 유저의 이벤트들을 정의한 공간 
          추상화시킨 Network를 삽입받아 사용하게 만듬으로 테스트코드 작성에 용이하게 만듬

TuistApp : 

Presenter의 영역 MVVM - C

Coordinator : View의 화면전환을 담당

ViewModel : ViewController와 1대 1 매칭 비즈니스 로직을 담당 Usecase를 주입받아 사용
            ViewController의 이벤트를 Input으로 받아 Transform 함수를 이용하여 Output으로 방출
            
ViewController : UI관련 이벤트들을 ViewModel transform 함수를 통해 전달 하여 Output으로 받아 UI작업에사용
                 Driver사용이유 MainScheduler 
                 UI와 관련된 subscription을 만들 때, Observable보다는 Driver를 사용하는 것이 좀 더 명확
                 UI 구성 SnapKit , Then

Dependencies : Swinject의 Assembler를 이용하여 의존성을 처리
-> 아직 미숙함이 보임 Provider을 이용하여 이미 제공자를 만들었는데 Assembler로 제공을 하는게 맞을까?
-> Provider를 가지고있는 Assembler 만들어 그 하위 Assembler에서 꺼내서 사용을 하고 있는데 이게 좋은 구조일까?
-> Coordinaotr Assembler 에서 BaseCoordinator을 변수로 받아 사용하고 있는데(BaseCoordinator는 탭이 늘어나거나 페이지가 변경되면 더 추가 될 수 있기에)이게 좋은 구조. 일까?


작성시 신경쓴점 

ViewModel , Coordinator의 생성시 필요한 값들이 페이지별로 다르기에 Builder를 이용하여 추상화된 다른 변수를 받을 수 있게 처리
상속을 최소화하고 추상화에 좀 더 초점을 둠
최대한 Protocol 하여 추상화된 값들을 외부에서 주입받도록 코드 처리 
중복되는 이벤트들은 제거하고 하나의 이벤트로 뭉칠수 있도록 처리
테스트코드는 최대안 안전하게 작성




#######
실제 검색까지 진행해보실 분들은
NetworkPlatform -> Network -> NetworkProvider에 들어가

Authorization의 값에 Daum 검색 API 키를 발급하여 사용

https://developers.kakao.com/docs/latest/ko/daum-search/dev-guide
