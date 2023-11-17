//
//  LoginViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import KeychainAccess
import FirebaseDatabase

class LoginViewController: TABackViewController{
    
    private lazy var logoImage: UIImageView = UIImage.cdlLogo().imageView()
    private lazy var getQuoteBtn: UIButton = .buttonStroke(title: "CDL")
    
    private lazy var welcomeLbl: UILabel = {
        let lbl = UILabel.displayXSBold()
        lbl.text = "Welcome home!"
        return lbl
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
    private lazy var loginBtn: UIButton = {
        let btn = UIButton.buttonFilled(title: "Login")
        btn.setOnClickListener(self, action: #selector(attemptLogin))
        return btn
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, loginBtn])
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var forgotPasswordBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.orange100(), for: .normal)
        btn.setTitle("Forgot Password", for: .normal)
        btn.titleLabel?.font = .textXSBold()
        /// btn.isHidden = true
        return btn
    }()
    
    private lazy var signUpLbl1: UILabel = {
        let lbl = UILabel.textSMBold(text: "Don't have a account ? ")
        lbl.textColor = .black
        return lbl
    }()
    private lazy var signUpLbl2: UILabel = {
        let lbl = UILabel.textSMBold(text: "Signup")
        lbl.textColor = .orange100()
        return lbl
    }()
    private lazy var signUpStackView: UIStackView = UIStackView(arrangedSubviews: [signUpLbl1, signUpLbl2])
    
    private lazy var ref : DatabaseReference! = Database.database().reference()
    
    private lazy var tAProgressHUD = TAProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .background()
        view.addViews(logoImage, getQuoteBtn, welcomeLbl, stackView, forgotPasswordBtn, signUpStackView)
        
        getQuoteBtn.constrainWidthTo(96)
        getQuoteBtn.constrainTrailingToTrailingOf(view: view, 24)
        getQuoteBtn.constrainTopToBottomOf(view: backStackView!, 28)
        logoImage.constrainHeightTo(40)
        logoImage.constrainWidthTo(33)
        logoImage.constrainToCenterYOf(view: getQuoteBtn)
        logoImage.constrainLeadingToLeadingOf(view: view, 24)
        
        welcomeLbl.constrainLeadingToLeadingOf(view: view, 24)
        welcomeLbl.constrainTopToBottomOf(view: getQuoteBtn, 38)
        
        stackView.constrainTopToBottomOf(view: welcomeLbl, 38)
        stackView.fillParentWithDefaultMargin(parent: view)
        
        forgotPasswordBtn.constrainToCenterXOf(view: view)
        forgotPasswordBtn.constrainTopToBottomOf(view: stackView, 20)
        
        
        signUpStackView.constrainToCenterXOf(view: view)
        signUpStackView.constrainBottomToBottomSafeAreaOf(view: view, 30)
        signUpStackView.setOnTapListener(action: navigateToSignup)
        
    }
    
    
    @objc
    func attemptLogin(){
        let email = emailField.getText().trim()
        if email.isEmpty || !email.isValidEmail() {
            ProgressHUD.showError("Enter a valid Email Address")
            return
        }
        let password = passwordField.getText().trim()
        if password.isEmpty{
            ProgressHUD.showError("Enter a valid Password")
            return
        }
        if password.count < 8{
            ProgressHUD.showError("Password should be at least 6 characters long")
            return
        }
        
        tAProgressHUD.show(on: view)
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let nsError = error as NSError
                switch AuthErrorCode(_nsError: nsError) {
                case AuthErrorCode.wrongPassword, AuthErrorCode.userNotFound, AuthErrorCode.invalidEmail:
                    self.showDismissableAlert(
                        title: "Login Failed",
                        msg: "Incorrect Username or Password",
                        actionTitle: "Try Again",
                        alertAction: self.attemptLogin
                    )
                default:
                    print("An error occurred")
                    self.throwGenericError(retryAction: self.attemptLogin)
                }
                return
            }
            else{
                guard let user = authResult?.user else {
                    self.throwGenericError(retryAction: self.attemptLogin)
                    return
                }
                //Goto the container View
                let controller = ContainerViewController()
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .flipHorizontal
                self.present(controller, animated: true, completion: {
                    self.navigationController?.popViewController(animated: false)
                })
            }
            self.tAProgressHUD.dismiss()
        }
    }
    
    private func throwGenericError(retryAction: @escaping () -> Void){
        self.tAProgressHUD.dismiss()
        self.showDismissableAlert(
            title: "Login Failed",
            msg: "An error occurred while logging you in",
            actionTitle: "Try Again",
            alertAction: retryAction
        )
    }
    
}
