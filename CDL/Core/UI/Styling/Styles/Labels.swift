//
//  Labels.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UILabel{
    
    static func generateLabel(font: UIFont, text: String = "", color: UIColor? = nil) -> UILabel{
        let lbl = UILabel()
        lbl.text = text
        lbl.font = font
        lbl.textColor = color
        return lbl
    }
    
    static func fieldTitle(text: String = "", color: UIColor? = nil) -> UILabel {
        let lbl = generateLabel(font: .latoRegular(12), text: text, color: color)
        lbl.addStyleDimensions(lineHeight: 14)
        return lbl
    }
    
    static func fieldHelperText(text: String = "", color: UIColor? = nil) -> UILabel {
        return .fieldTitle(text: text, color: color)
    }
    
}
