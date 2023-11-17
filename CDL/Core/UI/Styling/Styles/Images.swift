//
//  Images.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIImage{
    static func back() -> UIImage{
        return UIImage(named: "chevron_left")!
    }
    
    func imageView() -> UIImageView{
        return UIImageView(image: self)
    }
    
    static func cdlLogo() -> UIImage{
        return UIImage(named: "cdl_logo")!
    }
    
    static func eye() -> UIImage{
        return UIImage(named: "Eye")!
    }
    
    static func eyeSlash() -> UIImage{
        return UIImage(named: "EyeSlash")!
    }
    
    
    static func actionWarning() -> UIImage{
        return UIImage(named: "ActionWarning")!
    }

    static func close() -> UIImage{
        return UIImage(named: "close")!
    }
    
    func withPadding(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIImage {
        return withAlignmentRectInsets(UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right))
    }
    
    static func success() -> UIImage{
        return UIImage(named: "Success")!
    }
    
    

}
