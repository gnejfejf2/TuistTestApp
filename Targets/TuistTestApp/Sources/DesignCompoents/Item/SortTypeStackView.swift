//
//  SortTypeStackView.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/19.
//

import Foundation
import UIKit
import Then
import RxSwift
import SnapKit

class SortTypeStackView : UIStackView , ComponentSettingProtocol {
    
    lazy var itemStackView = UIStackView().then{
        
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        $0.addArrangedSubview(typeLabel)
        $0.addArrangedSubview(checkImage)
    }
    
    var typeLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    var checkImage = UIImageView().then{
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .primaryColor
        $0.isHidden = true
        $0.snp.makeConstraints { make in
            make.width.height.equalTo(15)
        }
    }
    var devideView = UIView().then{
        $0.backgroundColor = .placeholderText
        $0.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
    
    var item : ImageSearchRequestModel.SortType
    
    override init(frame: CGRect) {
        self.item = .recency
        super.init(frame: frame)
       
        uiSetting()
    }

    required init(coder aDecoder: NSCoder) {
        self.item = .recency
        super.init(coder: aDecoder)
        uiSetting()
    }
    convenience init(item: ImageSearchRequestModel.SortType) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.item = item
    }
    
    
    func uiSetting() {
        axis = .vertical
        spacing = 12
        distribution = .fill
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 0, trailing: 10)
        addArrangedSubview(itemStackView)
        addArrangedSubview(devideView)
    }
    
    
    func selectSetting(){
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        typeLabel.textColor = .primaryColor
        
        checkImage.isHidden = false
    }
    
    func unSelecteSetting(){
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        typeLabel.textColor = .placeholderText
        checkImage.isHidden = true
    }
    
}
