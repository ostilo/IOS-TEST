//
//  BaseTAField.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class OldTAFieldConfig: UIView {
    
    var fieldStrokeColor: UIColor = .darkNeutral40()
    var fieldBgColor: UIColor = .baseWhite()
    var fieldDisabledBgColor: UIColor = .additionals2()
    var titleTextColor: UIColor = .baseBlack()
    var fieldTextColor: UIColor = .baseBlack()
    var placeholderTextColor: UIColor = .cdlBlack50()
    var helperTextColor: UIColor = .darkNeutral60()
    
    var fieldUnitBgColor: UIColor = .additionals1()
    
    lazy var fieldUnitTextColor: UIColor = .darkNeutral80()
    lazy var fieldDividerColor: UIColor = .additionals2()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel.textSMRegular()
        lbl.textColor = titleTextColor
        return lbl
    }()
    
    func setTitleFontTo(_ font: UIFont){
        titleLbl.font = font
    }
    
}

class BaseTAField: UIStackView {
    
    var fieldDefaultStrokeColor: UIColor = .darkNeutral40()
    var fieldBgColor: UIColor = .clear
    var fieldDisabledBgColor: UIColor = .additionals2()
    var titleTextColor: UIColor = .baseBlack()
    var fieldTextColor: UIColor = .baseBlack()
    var placeholderTextColor: UIColor =  .darkNeutral60()
    
    var fieldFilledStrokeColor: UIColor = .baseBlack()
    var focusColor: UIColor = .orange100()
    var errorColor: UIColor = .error40()
    var titleTextDisabledColor: UIColor = .darkNeutral60()
    var filledDisabledBgColor: UIColor = .fieldDisabledBg()
    var helperTextColor: UIColor = .darkNeutral60()
    
    var fieldUnitBgColor: UIColor = .additionals1()
    
    var iconTint: UIColor =  .baseBlack()
    
    lazy var fieldUnitTextColor: UIColor = .darkNeutral80()
    lazy var fieldDividerColor: UIColor = .additionals2()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel.fieldTitle()
        lbl.textColor = titleTextColor
        return lbl
    }()
    
    lazy var helperLbl: UILabel = {
        let lbl = UILabel.fieldHelperText(color: helperTextColor)
        return lbl
    }()
       
    func setTitleFontTo(_ font: UIFont){
        titleLbl.font = font
    }
    
    init(withTitle: Bool = true){
        super.init(frame: .zero)
        axis = .vertical
        spacing = 8
        if withTitle {
            addArrangedSubviews(titleLbl)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

