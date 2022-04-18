//
//  AlertProtocol.swift
//  TuistTestApp
//
//  Created by 강지윤 on 2022/04/09.
//  Copyright © 2022 JYKang. All rights reserved.
//

import UIKit

public protocol AlertProtocol {
    func showAlert(title: String , message: String, preferredStyle: UIAlertController.Style , completion: (() -> Void)? )
}


public extension AlertProtocol where Self: UIViewController {
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        alert.addAction(success)
        self.present(alert, animated: true, completion: completion)
    }
}
