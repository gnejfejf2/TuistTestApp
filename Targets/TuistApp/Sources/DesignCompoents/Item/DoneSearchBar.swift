//
//  DoneSearchBar.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation
import UIKit


class DoneSearchBar : UISearchBar , ComponentSettingProtocol{
    
//    var doneAction : FunctionCloure? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    
    }
    func uiSetting(){
        let toolBarKeyboard = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBarKeyboard.sizeToFit()
         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let buttonDoneBar = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(doneButtonAction))
        toolBarKeyboard.items = [flexSpace , buttonDoneBar]
        self.inputAccessoryView = toolBarKeyboard
    }
    
    @objc func doneButtonAction(){
//        doneAction?()
        resignFirstResponder()
    }
}
