//
//  ScrollZoomImageView.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class ImageScrollView: UIScrollView , ComponentSettingProtocol{
    var imageZoomView = UIImageView()

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    
    }

    func uiSetting() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        decelerationRate = UIScrollView.DecelerationRate.fast
        backgroundColor = .primaryColorReverse
        addSubview(imageZoomView)
        
        
        imageZoomView.snp.makeConstraints { make in
            
//            make.width.equalTo(UIScreen.main.bounds.width)
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    func set(item: ImageSearchModel) {
        imageZoomView.contentMode = .scaleAspectFit
        imageZoomView.kf.setImage(with: URL(string: item.imageURL)){ [weak self] _ in
            guard let self = self else { return }
            self.imageZoomView.resizeImage(newWidth: UIScreen.main.bounds.width)
        }
    }
}

