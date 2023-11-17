//
//  UILabel+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UILabel{
    
    func addStyleDimensions(lineHeight: CGFloat? = nil, lineSpacing: CGFloat? = nil){
        let attr = getAttributedStringAsMutable()
        attr.addStyleDimensions(lineHeight: lineHeight, lineSpacing: lineSpacing)
        attributedText = attr
    }
    
    func getAttributedStringAsMutable() -> NSMutableAttributedString{
        return NSMutableAttributedString(attributedString: attributedText ?? NSAttributedString(string: ""))
    }
    
 
}
