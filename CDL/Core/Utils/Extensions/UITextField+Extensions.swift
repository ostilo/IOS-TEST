//
//  UITextField+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    func getTextAsDouble() -> Double{
        return Double(text ?? "0") ?? 0
    }
    
    func getTextAsInt() -> Int{
        return Int(text ?? "0") ?? 0
    }
    
    func setPlaceholderText(text: String){
        attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.accent5()])
    }
    
    func enablePasswordToggle(){
        let button = UIButton()
        button.setImage(.eye().withTintColor(Config.isRelease() ? .baseBlack() : .blackToWhiteField(), renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(.eyeSlash().withTintColor(Config.isRelease() ? .baseBlack() : .blackToWhiteField(), renderingMode: .alwaysOriginal), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.setOnTapListener {
            self.isSecureTextEntry.toggle()
            button.isSelected.toggle()
        }
        
        rightView = button
        rightViewMode = .always
    }
}

