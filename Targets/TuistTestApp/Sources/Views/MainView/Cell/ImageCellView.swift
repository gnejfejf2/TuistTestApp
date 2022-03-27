//
//  CategoryCollectionViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/19.
//

import UIKit
import SnapKit
import Then

import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell, CellSettingProtocl {
   
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    //UI
    var mainImageView = UIImageView().then{
        $0.contentMode = .scaleToFill
        
    }
    
    //Other
    var item: ImageSearchModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    
    func uiSetting() {
        addSubview(mainImageView)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        
        
    }
    
    func itemSetting(item : ImageSearchModel) {
        mainImageView.kf.setImage(with: URL(string: item.thumbnailURL))
    }
}

