//
//  MainViewController.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import UIKit
import Then
import SnapKit

class LoadingViewController : UIViewController {
    
//    var testClass : TestClass = TestClass()
    
   
    var loading = UIView().then {
        $0.backgroundColor = .red
        
    }
   
    override func viewDidLoad() {
        
        view.addSubview(loading)
        view.backgroundColor = .red
        loading.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        print("실행?")
    }
    
   

}




