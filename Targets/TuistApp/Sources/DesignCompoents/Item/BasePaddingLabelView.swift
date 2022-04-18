//
//  BasePaddingLabelView.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation
import UIKit
class BasePaddingLabelView: UILabel {
    private var padding = UIEdgeInsets(top: 8, left: 16.0, bottom: 8, right: 0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
