//
//  UIImageView+Rounded.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 07/12/2021.
//

import UIKit
extension UIImageView {
    func makeRoundImage() {
        let layer = CALayer()
        let origin = CGPoint(x: 0, y: self.bounds.height/2 - self.bounds.width/2)
        let size = CGSize(width: self.bounds.width, height: self.bounds.width)
        
        layer.frame = CGRect(origin: origin, size: size)
        layer.contents = self.image?.cgImage
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.size.width/2

        UIGraphicsBeginImageContext(size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image = roundedImage
    }
}
