//
//  File.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture

class DetailViewController : SuperViewControllerSetting<DetailViewModel>{
    
    
    //UI
    lazy var imageScrollView = ImageScrollView(frame: view.safeAreaLayoutGuide.layoutFrame)
    
    
    var exitButton  = UIButton().then{
        $0.setImage(UIImage(systemName : "xmark"), for: .normal)
        $0.tintColor = .primaryColor
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
    
    var imageInformationText = BasePaddingLabelView().then {
        $0.textColor = .white.withAlphaComponent(0.75)
        $0.backgroundColor = .darkGray1.withAlphaComponent(0.75)
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    var safeAreaBackground = UIView().then{
        $0.backgroundColor = .darkGray1.withAlphaComponent(0.75)
    }
    
    
    
    override func uiDrawing() {
        view.addSubview(imageScrollView)
        view.addSubview(exitButton)
        view.addSubview(imageInformationText)
        view.addSubview(safeAreaBackground)
        
        imageScrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(imageInformationText.snp.top)
        }
        
        exitButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageInformationText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaBackground.snp.top)
           
        }
        
        safeAreaBackground.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    override func viewModelBinding() {
        let exitAction = exitButton.rx.tap.asDriverOnErrorNever()
        
        
        
        let output = viewModel.transform(input: .init(
            exitAction : exitAction
        ))
        
        
        
        output.imageSearchModel
            .drive{ [weak self] imageSearchModel in
                guard let self = self else { return }
                self.imageScrollView.set(item: imageSearchModel)
            }
            .disposed(by: disposeBag)
        
        output.imageSearchModel
            .map{ $0.returnDescription() }
            .filter{ $0 != "" }
            .drive(imageInformationText.rx.text)
            .disposed(by: disposeBag)
        
        output.imageSearchModel
            .map{
                if($0.returnDescription() == ""){
                    return .clear
                }else{
                    return .darkGray1.withAlphaComponent(0.75)
                }
            }
            .drive(imageInformationText.rx.backgroundColor , safeAreaBackground.rx.backgroundColor)
            .disposed(by: disposeBag)
        
    }
    
 
    
    
}


