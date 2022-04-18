
import Foundation
import UIKit
import RxSwift
//뷰상단에 변수를 선언할때 or UI를 선언할때
//순서
// UI -> DataSource -> 변수 -> 기타값

protocol ViewSettingProtocol {
    associatedtype T
    var viewModel : T { get }
    var disposeBag : DisposeBag { get }
    
    init(viewModel : T)
    //uiSetting
    //view.add , snp 옵션 로직등이 이곳에서 설정된다
    func uiDrawing()
    //ui 옵션들이 설정되는공간이다
    //델리게이트설정 , 백그라운드설정 등이 이루어진다
    func uiSetting()
    //ui 뷰모델을 바인딩 시키는 공간
    func viewModelBinding()
  
}


class SuperViewControllerSetting<U> : UIViewController , ViewSettingProtocol {
    typealias T = U
   
    let viewModel : T
    let disposeBag = DisposeBag()
    
    convenience init(){
        fatalError("init()")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder :)")
    }
    
    required init(viewModel : T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColorReverse
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
       
      
        
        uiDrawing()
        uiSetting()
        viewModelBinding()
        
    }
    
    func uiDrawing() {
       
     
    }
    
    func uiSetting() {

       
    }
    
    func viewModelBinding() {
        
        
    }
    
   
}

