//
//  BottomSheetViewController.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import UIKit
import SnapKit
import Then



protocol BottomSheetSettingProtocol{
    func uiSetting()
    func eventSetting()
    
    func showBottomSheet()
    func hideBottomSheet()
}

@objc protocol BottomSheetControlEventProtocl {
    
    @objc func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer)
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer)
}

class BottomSheetView : UIView , BottomSheetSettingProtocol{
    
    // 1
    private let dimmedView = UIView().then{
        $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
    }
    
    lazy var bottomSheetView = UIStackView().then{
        $0.backgroundColor = .primaryColorReverse
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: UIApplication.shared.windows.first!.safeAreaInsets.bottom, trailing: 16)
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
   
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    
    lazy var defaultHeight: CGFloat = bottomSheetView.frame.height
    lazy var bottomSheetPanMinTopConstant : CGFloat = defaultHeight
    var bottomSheetPanStartingTopConstant : CGFloat = 0
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
        eventSetting()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
        eventSetting()
    }
    
    func uiSetting(){
        addSubview(dimmedView)
        addSubview(bottomSheetView)
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheetView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: bottomAnchor)
        bottomSheetViewTopConstraint.isActive = true
    
        isHidden = true
    }
    
    func eventSetting(){
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        // Pan Gesture Recognizer를 view controller의 view에 추가하기 위한 코드
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        // 기본적으로 iOS는 터치가 드래그하였을 때 딜레이가 발생함
        // 우리는 드래그 제스쳐가 바로 발생하길 원하기 때문에 딜레이가 없도록 아래와 같이 설정
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        addGestureRecognizer(viewPan)
    }
    
    func showBottomSheet() {
        defaultHeight = bottomSheetView.frame.height
        bottomSheetViewTopConstraint.constant = -defaultHeight
      
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = 0.7
            self.isHidden = false
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    func hideBottomSheet() {
        bottomSheetViewTopConstraint.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = 0.0
            self.layoutIfNeeded()
        }) { [weak self] _ in
            guard let self = self else { return }
            self.isHidden = true
        }
    }

    
}

extension BottomSheetView : BottomSheetControlEventProtocl{
    @objc func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheet()
    }
    
    // 해당 메소드는 사용자가 view를 드래그하면 실행됨
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self)

        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if(bottomSheetPanStartingTopConstant +  translation.y > 0){
                bottomSheetViewTopConstraint.constant = 0
                hideBottomSheet()
            }else if(bottomSheetPanStartingTopConstant +  translation.y < -defaultHeight){
                bottomSheetViewTopConstraint.constant = -defaultHeight
            }else{
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant +  translation.y
            }
        case .ended:
           //특정값보다 작아지면 화면이 사라지게
            if(bottomSheetViewTopConstraint.constant > -100 && bottomSheetViewTopConstraint.constant < 0){
                hideBottomSheet()
            //특정값사이면 기본크기로
            }else if (bottomSheetViewTopConstraint.constant < -100 && bottomSheetViewTopConstraint.constant > -300){
                showBottomSheet()
            }
        default:
            break
        }
    }
}
