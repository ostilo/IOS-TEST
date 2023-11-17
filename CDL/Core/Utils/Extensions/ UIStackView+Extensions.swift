//
//   UIStackView+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...){
        for view in views {
            view.isHidden = false
            self.addArrangedSubview(view)
        }
    }
    
    func removeSubview(_ view: UIView){
        removeArrangedSubview(view)
        view.isHidden = true
    }
    
    func removeArrangedSubviews(_ views: UIView...){
        for view in views {
            view.isHidden = true
            removeArrangedSubview(view)
        }
    }
    
    func addPaddings(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0){
        layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        isLayoutMarginsRelativeArrangement = true
    }
    
    func removeArrangedSubviews(_ views: [UIView]){
        for i in 0..<views.count {
            removeSubview(views[i])
        }
    }
    
}
