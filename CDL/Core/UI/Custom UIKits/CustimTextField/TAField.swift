//
//  TAField.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

protocol TAField {
    
    func getText() -> String
    
    func setText(_ text: String)
    
    func setErrorMsg(_ msg: String)
    
    func clearErrorMsg()
    
    func disableField()
    
    func enableField()
    
    func setTextFieldKeyboardTypeAs(_ keyboardType: UIKeyboardType)
    
    func setBackgroundColorTo(_ color: UIColor)
    
    func setPlaceholderText(text: String)
    
    func clearField()
    
}

