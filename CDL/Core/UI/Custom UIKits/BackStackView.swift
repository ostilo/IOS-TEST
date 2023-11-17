//
//  BackStackView.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class BackStackView: UIStackView {
    
    private lazy var backIcon: UIImageView = {
        let imageView = UIImage.back().imageView()
        imageView.constrainHeightTo(16)
        return imageView
    }()
    private lazy var backLabel: UILabel = {
        let label = UILabel.textXSRegular()
        label.text = "Back"
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        addArrangedSubview(backIcon)
        addArrangedSubview(backLabel)
        axis = .horizontal
        spacing = 10
        constrainHeightTo(27)
        alignment = .center
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

