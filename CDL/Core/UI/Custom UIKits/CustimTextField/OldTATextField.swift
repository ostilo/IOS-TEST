//
//  OldTATextField.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class OldTATextField: OldTAFieldConfig, TAField{
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = self.fieldTextColor
        textField.font = .textMDRegular()
        return textField
    }()
    lazy var textViewBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = fieldStrokeColor.cgColor
        view.layer.cornerRadius = 8
        view.backgroundColor = fieldBgColor
        view.constrainHeightTo(50)
        return view
    }()
    lazy var helperLbl: UILabel = {
        let lbl = UILabel.textSMBold()
        lbl.textColor = .error()
        return lbl
    }()
        
    init(title: String? = nil, placeholder: String? = nil, keyboardType: UIKeyboardType? = nil) {
        super.init(frame: .zero)
        
        addViews(titleLbl, textViewBackgroundView, textField, helperLbl)
        
        titleLbl.constrainTopToTopOf(view: self)
        titleLbl.constrainLeadingToLeadingOf(view: self)
        
        textViewBackgroundView.constrainTopToBottomOf(view: titleLbl, 6)
        textViewBackgroundView.constrainLeadingToLeadingOf(view: self)
        textViewBackgroundView.constrainTrailingToTrailingOf(view: self)
        

        textField.constrainLeadingToLeadingOf(view: textViewBackgroundView, 14)
        textField.constrainTrailingToTrailingOf(view: textViewBackgroundView, 14)
        textField.constrainToCenterYOf(view: textViewBackgroundView)
        
        helperLbl.constrainHeightTo(20)
        helperLbl.constrainTopToBottomOf(view: textViewBackgroundView, 6)
        helperLbl.constrainLeadingToLeadingOf(view: self)
        helperLbl.constrainBottomToBottomOf(view: self)
        
        titleLbl.text = title
        if let placeholder = placeholder {
            setPlaceholderText(text: placeholder)
        }
        if let keyboardType = keyboardType {
            setTextFieldKeyboardTypeAs(keyboardType)
        }
    }
    
    func getText() -> String{
        return textField.text?.trim() ?? ""
    }
    
    func getTextAsInt() -> Int{
        return textField.getTextAsInt()
    }
    
    func setText(_ text: String){
        textField.text = text
    }
    
    func setErrorMsg(_ msg: String){
        helperLbl.text = msg
        helperLbl.textColor = .error()
    }
    
    func clearErrorMsg(){
        helperLbl.text = ""
    }
    
    func disableField(){
        textField.isUserInteractionEnabled = false
        textViewBackgroundView.backgroundColor = fieldDisabledBgColor
    }
    
    func enableField() {
        textField.isUserInteractionEnabled = true
        textViewBackgroundView.backgroundColor = fieldBgColor
    }
    
    func setTextFieldKeyboardTypeAs(_ keyboardType: UIKeyboardType){
        textField.keyboardType = keyboardType
    }
    
    func setBackgroundColorTo(_ color: UIColor){
        textViewBackgroundView.backgroundColor = color
    }
    
    func setPlaceholderText(text: String){
        textField.setPlaceholderText(text: text)
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: self.placeholderTextColor]
        )
    }
    
    func clearField(){
        textField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

func generateTATextFieldWithoutTitle(hint: String = "") -> UITextField {
    let textField = UITextField()
    textField.setPlaceholderText(text: hint)
    textField.layer.backgroundColor = UIColor.baseWhite().cgColor
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.gray300().cgColor
    textField.layer.cornerRadius = 8
    textField.paddingLeftCustom = 14
    textField.paddingRightCustom = 14
    textField.constrainHeightTo(44)
    textField.textColor = .brand5()
    textField.font = .textMDRegular()
    return textField
}

func generateSearchField() -> UITextField {
    let field = UITextField()
    field.layer.backgroundColor = UIColor.additionals1().cgColor
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.gray300().cgColor
    field.layer.cornerRadius = 8
    field.paddingLeftCustom = 14
    field.textColor = .textDefault()
    field.constrainHeightTo(44)
    field.returnKeyType = .search
    field.setPlaceholderText(text: "Search")
    field.clearButtonMode = .whileEditing
    field.font = .textMDRegular()
    return field
}

class TATextField: BaseTAField, TAField {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = self.fieldTextColor
        textField.font = .inputFieldText()
        return textField
    }()
    
    lazy var iconIV: UIImageView = {
        let iv = UIImageView()
        iv.constrainHeightTo(24)
        iv.constrainWidthTo(24)
        return iv
    }()
    var userCanSelectCountry = false
    lazy var countryCodeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "***"
        lbl.setContentHuggingPriority(.required, for: .horizontal)
        lbl.textColor = placeholderTextColor
        lbl.font = .latoRegular(16)
        return lbl
    }()

    lazy var dividerV: UIView = {
        let view = UIView()
        view.constrainWidthTo(1)
        view.backgroundColor = fieldDefaultStrokeColor
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = fieldDefaultStrokeColor.cgColor
        view.layer.cornerRadius = 8
        view.constrainHeightTo(48)
        return view
    }()
    
    init(withTitle: Bool = true, title: String? = nil, placeholder: String? = nil, img: UIImage? = nil, keyboardType: UIKeyboardType? = nil) {
        super.init(withTitle: withTitle)
        
        addArrangedSubviews(containerView)
        
        titleLbl.text = title
        if let placeholder = placeholder {
            setPlaceholderText(text: placeholder)
        }
        
        if let keyboardType = keyboardType {
            setTextFieldKeyboardTypeAs(keyboardType)
        }
        
        if keyboardType == .phonePad {
          
        }else{
            setupTextContainerView(withImage: img)
        }
      
        textField.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextContainerView(withImage img: UIImage? = nil){
        containerView.addViews(textField)
        if let img = img {
            iconIV.image = img.withTintColor(iconTint, renderingMode: .alwaysOriginal)
            containerView.addViews(iconIV)
            iconIV.constrainLeadingToLeadingOf(view: containerView, 16)
            iconIV.constrainToCenterYOf(view: containerView)
            textField.constrainLeadingToTrailingOf(view: iconIV, 16)
        }else{
            textField.constrainLeadingToLeadingOf(view: containerView, 16)
        }
        
        textField.constrainToCenterYOf(view: containerView)
        textField.constrainTrailingToTrailingOf(view: containerView, 16)
    }
    
  
    
    func getText() -> String{
        return textField.text?.trim() ?? ""
    }
    
    func setText(_ text: String){
        textField.text = text
    }
    
    func setErrorMsg(_ msg: String){
        titleLbl.textColor = errorColor
        helperLbl.text = msg
        helperLbl.textColor = errorColor
        containerView.customiseBorder(color: errorColor)
        dividerV.backgroundColor = errorColor
        addArrangedSubviews(helperLbl)
    }
    
    func clearErrorMsg(){
        titleLbl.textColor = titleTextColor
        removeArrangedSubviews(helperLbl)
        helperLbl.text = ""
        helperLbl.textColor = helperTextColor
        containerView.customiseBorder(color: fieldDefaultStrokeColor)
        dividerV.backgroundColor = fieldDefaultStrokeColor
    }
    
    func disableField(){
        textField.isUserInteractionEnabled = false
        containerView.backgroundColor = fieldDisabledBgColor
    }
    
    func enableField() {
        textField.isUserInteractionEnabled = true
        containerView.backgroundColor = fieldBgColor
    }
    
    func setTextFieldKeyboardTypeAs(_ keyboardType: UIKeyboardType){
        textField.keyboardType = keyboardType
    }
    
    func setBackgroundColorTo(_ color: UIColor){
        containerView.backgroundColor = color
    }
    
    func setPlaceholderText(text: String){
        textField.setPlaceholderText(text: text)
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: self.placeholderTextColor]
        )
    }
    
    func clearField(){
        textField.text = ""
    }
    
    func fieldHasFocus(){
        titleLbl.textColor = focusColor
        countryCodeLbl.textColor = fieldTextColor
        helperLbl.textColor = helperTextColor
        containerView.customiseBorder(color: focusColor)
        dividerV.backgroundColor = focusColor
    }
    
    func fieldLostFocus(){
        titleLbl.textColor = titleTextColor
        if textField.text?.isEmpty == true {
            countryCodeLbl.textColor = placeholderTextColor
            containerView.customiseBorder(color: fieldDefaultStrokeColor)
            dividerV.backgroundColor = fieldDefaultStrokeColor
        }else{
            countryCodeLbl.textColor = fieldTextColor
            containerView.customiseBorder(color: fieldFilledStrokeColor)
            dividerV.backgroundColor = fieldFilledStrokeColor
        }
    }
    
    func getPhoneNumber() -> String{
        let number = textField.text ?? ""
        if number.isEmpty {
            setErrorMsg("Enter a Phone number")
            return ""
        }
        if phoneCode.isEmpty {
            setErrorMsg("Select a Country phone code")
            return ""
        }
        return "+\(phoneCode)\(number)"
    }
    
    private var phoneCode = ""
    func countrySelectedWith(phoneCode: String, flag: String){
        self.phoneCode = phoneCode
        countryCodeLbl.text = "\(flag) +\(phoneCode)"
        clearErrorMsg()
    }
    
}

extension TATextField: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldHasFocus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldLostFocus()
    }
}
