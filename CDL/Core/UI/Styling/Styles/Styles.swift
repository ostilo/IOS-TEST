//
//  Styles.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIFont{
    
    static func textXSRegular() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
    }
    
    static func textSMRegular() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func textMDRegular() -> UIFont {
        return UIFont(name: "Lato-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }
    
    
    static func displayXSBold() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func textXSBold() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 12)  ?? UIFont.boldSystemFont(ofSize: 12)
    }
    
    static func textSMBold() -> UIFont {
        return UIFont(name: "Lato-Bold", size: 14)  ?? UIFont.boldSystemFont(ofSize: 14)
    }
    
}

extension UILabel {
  
    static func textXSRegular(text: String = "", color: UIColor = .textDefault()) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .textXSRegular()
        label.textColor = color
        return label
    }
    
    static func displayXSBold(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .displayXSBold()
        label.textColor = .textDefault()
        return label
    }
    
    static func textXSBold(text: String = "", color: UIColor = .textDefault()) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .textXSBold()
        label.textColor = color
        return label
    }
    
    static func textSMBold(text: String = "", color: UIColor = .textDefault()) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .textSMBold()
        label.textColor = color
        return label
    }
    
    static func textSMRegular(text: String = "", color: UIColor = .textDefault()) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .textSMRegular()
        label.textColor = color
        return label
    }
    
    
}

extension UIButton{
    
    static func oldButton(isFullSized: Bool = true) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .textSMRegular()
        button.cornerRadius = 8
        
        if isFullSized {
            button.constrainHeightTo(50)
        }
        return button
    }
    
    static func buttonFilled(title: String, backgroundColor: UIColor = .orange100(), textColor: UIColor = .baseWhite(), isFullSized: Bool = true, font: UIFont? = nil) -> UIButton {
        let button = UIButton.oldButton(isFullSized: isFullSized)
        button.backgroundColor = backgroundColor
        button.setTitleColor( textColor, for: .normal)
        button.setTitle(title, for: .normal)
        
        if let font = font {
            button.titleLabel?.font = font
        }
        
        return button
    }
    
    static func buttonStroke(title: String, backgroundColor: UIColor = .baseWhite(), strokeColor: UIColor = .orange100(), textColor: UIColor? = nil) -> UIButton {
        let button = UIButton.oldButton()
        button.backgroundColor = backgroundColor
        
        let titleColor = {
            if let color = textColor {
                return color
            }else{
                return strokeColor
            }
        }()
        button.setTitleColor( titleColor, for: .normal)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = strokeColor.cgColor
        button.setTitle(title, for: .normal)
        return button
    }
    
}
