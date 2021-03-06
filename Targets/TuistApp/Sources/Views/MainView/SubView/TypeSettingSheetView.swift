//
//  TypeSettingSheetView.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/19.
//
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

import Domain
protocol BottomSheetItemSettingProtocol {
    var sortTypeViewArray : [SortTypeStackView] { get set }
    
    func bottomSheetItemSetting()
    func sortTypeSetting(type : SortType)
}

class SpotBottomSheetView : BottomSheetView , BottomSheetItemSettingProtocol {
  
    
    
    //UI
    lazy var mainKeyword = UILabel().then{
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "정렬"
    }
    
    var inOrderOfAccuracy : SortTypeStackView = SortTypeStackView(item : .accuracy).then{
        $0.typeLabel.text =  "정확도순"
        $0.selectSetting()
    }
    var inOrderOfRecency : SortTypeStackView = SortTypeStackView(item : .recency).then{
        $0.typeLabel.text =  "최신순"
        $0.unSelecteSetting()
    }
    
    
    
    //Other
    lazy var sortTypeViewArray : [SortTypeStackView]  = [inOrderOfAccuracy,inOrderOfRecency]
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomSheetItemSetting()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bottomSheetItemSetting()
    }
    
    func bottomSheetItemSetting(){
        bottomSheetView.addArrangedSubview(mainKeyword)
        sortTypeViewArray.forEach{ [weak self] in
            guard let self = self else { return }
            self.bottomSheetView.addArrangedSubview($0)
        }
        
    }
    
}


extension BottomSheetItemSettingProtocol {
    func sortTypeSetting(type : SortType){
        sortTypeViewArray.forEach{
            if($0.item == type){
                $0.selectSetting()
            }else{
                $0.unSelecteSetting()
            }
        }
    }
}
