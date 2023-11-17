//
//  UIButton+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIButton {
    
    func setOnClickListener(_ target: Any?, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func disableBtn(){
        isEnabled = false
        backgroundColor = .accent5()
//        alpha = 0.4
    }
    
    func enableBtn(bgColor: UIColor = .orange100()){
        isEnabled = true
        backgroundColor = bgColor
    }
    
    func addImageToTheRight(image: UIImage){
        setImage(image, for: .normal)
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    func addImageToTheLeft(image: UIImage,_ paddingRight: CGFloat = 16){
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: paddingRight)
    }
    
    func addPadding(top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil){
        if let top = top {
            contentEdgeInsets.top = top
        }
        if let bottom = bottom {
            contentEdgeInsets.bottom = bottom
        }
        if let left = left {
            contentEdgeInsets.left = left
        }
        if let right = right {
            contentEdgeInsets.right = right
        }
    }
    
}
