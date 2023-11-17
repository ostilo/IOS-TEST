//
//  CollectPersonalInfoView.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class CollectPersonalInfoView: UIScrollView {
    
    private lazy var titleLbl: UILabel = .displayXSBold(text: "Create an account")
    private lazy var subtitleLbl: UILabel = {
        let lbl = UILabel.textSMRegular(text: "Enter your details to proceed")
        lbl.textColor = .accent5()
        return lbl
    }()
    
    private lazy var fullNameField: OldTATextField = {
        let field = OldTATextField()
        field.titleLbl.text = "Full Name"
        return field
    }()
    
    private lazy var emailField: OldTATextField = {
        let field = OldTATextField()
        field.titleLbl.text = "Email"
        field.textField.keyboardType = .emailAddress
        return field
    }()
    
    
    private lazy var passwordField: OldTATextField = {
        let field = OldTATextField()
        field.titleLbl.text = "Password"
        field.textField.isSecureTextEntry = true
        field.textField.enablePasswordToggle()
        return field
    }()
    
    private lazy var businessInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fullNameField, emailField, passwordField])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var contentView: UIView = UIView()

    
    init(parentViewController: UIViewController) {
        super.init(frame: .zero)
        addViews(contentView)
        
        contentView.constrainTopToTopOf(view: self)
        contentView.constrainBottomToBottomOf(view: self)
        contentView.constrainToCenterXOf(view: self)
        contentView.constrainWidthToEqual(self)
        contentView.addViews(titleLbl, subtitleLbl, businessInfoStackView)

        titleLbl.constrainTopToTopOf(view: contentView, 22)
        titleLbl.constrainLeadingToLeadingOf(view: contentView, 24)
        subtitleLbl.constrainTopToBottomOf(view: titleLbl, 10)
        subtitleLbl.constrainLeadingToLeadingOf(view: titleLbl)

        businessInfoStackView.constrainTopToBottomOf(view: subtitleLbl, 20)
        businessInfoStackView.constrainLeadingToLeadingOf(view: contentView, 24)
        businessInfoStackView.constrainTrailingToTrailingOf(view: contentView, 24)
        businessInfoStackView.constrainBottomToBottomOf(view: contentView)

        
        
    }
    
    //
    func generateCreatePersonalRequest() -> CreatePersonalRequest?{
        clearAllErrorMsgs();
        
        var allFieldsValid = true
        
        let fullName = fullNameField.getText()
        if fullName.isEmpty {
            allFieldsValid = false
            fullNameField.setErrorMsg("Enter your First Name")
        }
        
        let email = emailField.getText()
        if email.isEmpty {
            allFieldsValid = false
            emailField.setErrorMsg("Enter your Email Address")
        }else if !email.isValidEmail(){
            allFieldsValid = false
            emailField.setErrorMsg("Enter a valid Email Address")
        }
        
        let password = passwordField.getText()
        if password.isEmpty {
            allFieldsValid = false
            passwordField.setErrorMsg("Enter your Password")
        } else if password.count < 8 {
            allFieldsValid = false
            passwordField.setErrorMsg("Password must be at least 8 characters")
        }
        if allFieldsValid {
            return CreatePersonalRequest(email: email, fullName: fullName, password: password)
        }else{
            return nil
        }
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func clearAllErrorMsgs(){
        fullNameField.clearErrorMsg()
        emailField.clearErrorMsg()
        passwordField.clearErrorMsg()
    }
}
