//
//  NSAttributedString+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import Foundation
import UIKit

extension NSMutableAttributedString{
    func addAttributesToString(_ text: String, attrs: [NSAttributedString.Key : Any]){
        let range = mutableString.range(of: text)
        addAttributes(attrs, range: range)
    }
    
    func addStyleDimensions(lineHeight: CGFloat? = nil, lineSpacing: CGFloat? = nil){
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
        }
        
        addAttributesToString(string, attrs: [.paragraphStyle: paragraphStyle])
    }
}
