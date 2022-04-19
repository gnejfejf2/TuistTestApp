////
////  BrandiAppTests.swift
////  BrandiAppTests
////
////  Created by 강지윤 on 2022/03/17.
////

import XCTest
import Domain
import RxTest
import RxSwift


@testable import TuistApp

class MainViewModelUnitTest: XCTestCase {
    //
    let disposeBag = DisposeBag()
    var viewModel: MainViewModel!
    var scheduler: TestScheduler!
    let searchAction = PublishSubject<String>()
    let bottomScrollTriger = PublishSubject<Void>()
    let cellClick = PublishSubject<ImageSearchModel>()
    let sortTypeAction = PublishSubject<SortType>()
    var output : MainViewModel.Output!
    
    
    // MARK: - GIVEN
    override func setUp() {
        
        let coordinaotr = MainViewCoordinator(navigationController: UINavigationController())
        viewModel = MainViewModel(imageSearchUseCase: ImageSearchMock(), builder: .init(coordinator: coordinaotr))
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
        output = viewModel.transform(input: .init(searchAction: searchAction.asDriverOnErrorNever(), bottomScrollTriger: bottomScrollTriger.asDriverOnErrorNever(), cellClick: cellClick.asDriverOnErrorNever(), sortTypeAction: sortTypeAction.asDriverOnErrorNever()))
        
        
    }
    
    //검색기능 테스트코드 "강지윤강지" 라는 키워드로 1페이지를 검색
    func testSearch_강지윤강지_1_페이지(){
        
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(Int?.self)
        
        
        
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //검색기능 테스트코드 "강지윤강지" 라는 키워드로 1페이지를 검색
    func testSearch_강지윤강지_1페이지바로요청_첫번째_마지막_아이템체크(){
        //Given
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(String?.self)
        
        
        
        //When
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.first?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.last?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<String?>>] = [
            .next(0, nil),
            .next(0, nil),
            .next(100 ,
                  "cafe"),
            .next(100 ,
                  "blog"
                 )
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    
    //1페이지를 건너뛰고 2페이지를 바로 검색
    func testSearch_강지윤강지_2_페이지(){
        //Given
        viewModel.itemCount = 10
        viewModel.pagingCount = 2
        let observer = scheduler.createObserver(Int?.self)
        
        
        //when
        
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //Then
        //검색을 요청할경우 페이징카운터 , TotalCount를 초기화 하기에 1번이 검색되는게 맞음
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10)
        ]
        
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    //1페이지를 건너뛰고 2페이지를 바로 검색
    //정확한 1페이지로 정확하게 검색이 되는지 아이템체크
    func testSearch_강지윤강지_2페이지바로요청_첫번째_마지막_아이템체크(){
        //Given
        viewModel.itemCount = 10
        viewModel.pagingCount = 2
        let observer = scheduler.createObserver(String?.self)
        
        
        //when
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.first?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.last?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //Then
        let exceptEvents: [Recorded<Event<String?>>] = [
            .next(0, nil),
            .next(0, nil),
            .next(100 ,
                  "cafe"),
            .next(100 ,
                  "blog"
                 )
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    //
    //1페이지 검색후
    //바텀에 도달하여 2페이지 검색요청
    func testSearch_강지윤강지_1페이지검색_2페이지인피니티스크롤(){
        //Given
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(Int?.self)
        
        //when
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //Then
        //1번 아이템의 갯수 10개
        //2차 요청갯수 2개 토탈 12개 맞다.
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10),
            .next(200 , 12)
        ]
        
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //1페이지 검색후
    //바텀에 도달하여 2페이지 검색요청
    //첫번째 두번째 아이템체크
    func testSearch_강지윤강지_1페이지검색_2페이지인피니티스크롤_첫번째_마지막아이템체크(){
        //Given
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(String?.self)
        
        //when
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.first?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.last?.collection }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //Then
        let exceptEvents: [Recorded<Event<String?>>] = [
            .next(0, nil),
            .next(0, nil),
            .next(100 ,
                  "cafe"),
            .next(100 ,
                  "blog"),
            .next(200 ,
                  "cafe"),
            .next(200 ,
                  "news"
                 )
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //1페이지 검색후
    //바텀에 도달하여 2페이지 검색요청
    //그후 또다시 바텀에 도달하여 3페이지 요청
    func testSearch_강지윤강지_1페이지검색_2페이지인피니티스크롤_3페이지인피니티스크롤(){
        //Given
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(Int?.self)
        //when
        
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(300 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        //Then
        //1번 아이템의 갯수 10개
        //2차 요청갯수 2개 토탈 12개 맞다.
        //3차 요청시 더이상 요청할 아이템이없기에 요청이 생기지 않아 200에서 더이상 이벤트가 방출되지않는다.
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10),
            .next(200 , 12)
        ]
        
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //검색기능 테스트코드 "Swift" 라는 키워드로 1페이지를 검색
    func testSearch_Swift_1_페이지(){
        
        let observer = scheduler.createObserver(Int?.self)
        
        scheduler.createHotObservable([.next(100 , "Swift")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count ?? 0 }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , 0),
            .next(100 , 30)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //검색기능 테스트코드 "Swift" 라는 키워드로 1,2페이지를 검색
    func testSearch_Swift_1_2_페이지(){
        
        let observer = scheduler.createObserver(Int.self)
        
        scheduler.createHotObservable([.next(100 , "Swift")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count ?? 0 }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(0 , 0),
            .next(100 , 30),
            .next(200 , 60)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    //검색기능 테스트코드 "Swift" 라는 키워드로 1,2,3페이지를 검색
    func testSearch_Swift_1_2_3_페이지(){
        let observer = scheduler.createObserver(Int.self)
        
        scheduler.createHotObservable([
            .next(100 , "Swift")
        ])
        .bind(to: searchAction)
        .disposed(by: disposeBag)
        
        scheduler.createHotObservable([
            .next(200 , ()),
            .next(300 , ())
        ])
        .bind(to: bottomScrollTriger)
        .disposed(by: disposeBag)
        
        
        //        scheduler.create
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count ?? 0 }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(0 , 0),
            .next(100 , 30),
            .next(200 , 60),
            .next(300 , 90)
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    func testSearch_강지윤강지_1_정확도순_최신순(){
        
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(Int?.self)
        
        
        
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , .recency)])
            .bind(to: sortTypeAction)
            .disposed(by: disposeBag)
        
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10),
            .next(200 , 10)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    
    func testSearch_강지윤강지_1_정확도순_최신순_2페이지요청(){
        
        viewModel.itemCount = 10
        let observer = scheduler.createObserver(Int?.self)
        
        
        
        scheduler.createHotObservable([.next(100 , "강지윤강지")])
            .bind(to: searchAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , .recency)])
            .bind(to: sortTypeAction)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(300 , ())])
            .bind(to: bottomScrollTriger)
            .disposed(by: disposeBag)
        
        output.imageSearchModels
            .asObservable()
            .map{ $0.first?.items.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , nil),
            .next(100 , 10),
            .next(200 , 10),
            .next(300 , 13)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
}

