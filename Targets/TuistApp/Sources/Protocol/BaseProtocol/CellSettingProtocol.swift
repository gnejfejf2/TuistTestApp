//
//  CellProtocol.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation

protocol CellSettingProtocl {
    associatedtype U
    var item : U? { get set }
    //UI관련작업 ex) addSubview , Snapkit 등등
    func uiSetting()
    //외부에서 받은 아이템받아 ui에 값을 넣어준다.
    func itemSetting(item : U)
}
