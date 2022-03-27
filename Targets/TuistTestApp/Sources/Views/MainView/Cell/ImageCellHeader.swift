//
//  ImageCellHeader.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/19.
//

import UIKit
import SnapKit
import Then


protocol SectionHeaderTypeChangeDelegate {
    func sortTypeAction(type : ImageSearchRequestModel.SortType)
}

class ImageCellHeader: UICollectionReusableView , SectionHeaderTypeChangeDelegate{
  
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
   
    //UI
    let sortTypeButton = UIButton().then{
        $0.setTitle(ImageSearchRequestModel.SortType.accuracy.rawValue, for: .normal)
        $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        $0.tintColor = .primaryColor
        $0.setTitleColor(.primaryColor, for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func uiSetting(){
        backgroundColor = .primaryColorReverse
        addSubview(sortTypeButton)
        sortTypeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        sortTypeButton.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        sortTypeButton.isUserInteractionEnabled = true
    }
 
    @objc func clickAction(){
        
    }
}

extension ImageCellHeader{
    func sortTypeAction(type: ImageSearchRequestModel.SortType) {
        if(type == .accuracy){
            sortTypeButton.setTitle("정확도순", for: .normal)
        }else{
            sortTypeButton.setTitle("최신순", for: .normal)
        }
    }
}

