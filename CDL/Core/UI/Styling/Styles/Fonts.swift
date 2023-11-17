//
//  Fonts.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIFont{
    static func latoRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size)!
    }
    
    static func inputFieldText() -> UIFont {
        return latoRegular(16)
    }
}
