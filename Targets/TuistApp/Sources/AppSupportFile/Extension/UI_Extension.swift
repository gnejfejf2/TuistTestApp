//
//  UI_Extension.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation
import UIKit

extension UIImageView {
    func resizeImage(newWidth: CGFloat){
        self.image = self.image?.resize(newWidth: newWidth)
    }
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image {
            context in self.draw(in: CGRect(origin: .zero, size: size))
            
        }
        return renderImage
    }
}
