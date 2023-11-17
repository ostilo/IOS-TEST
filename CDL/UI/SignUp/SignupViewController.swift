//
//  SignupViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import KeychainAccess

class SignupViewController: TABackViewController {
    
    private lazy var actionBtn: UIButton = .buttonFilled(title: "Continue")
    private lazy var loginLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = .textDefault()
        var str = "Already have an account ? Login"
        var myMutableString = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font: UIFont.textXSBold()])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange100(), range: NSRange(location: str.count - 5, length: 5))
        lbl.attributedText = myMutableString
        lbl.textAlignment = .center
        
        lbl.setOnTapListener {
            let controller = LoginViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return lbl
    }()
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actionBtn, loginLbl])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 24, bottom: 25, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .fill
        stackView.backgroundColor = .additionals1()
        return stackView
    }()
    
    private var createPersonalRequest: CreatePersonalRequest?

    
    
    private lazy var collectPeronalInfoView = CollectPersonalInfoView(parentViewController: self)

    private lazy var tAProgressHUD = TAProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addViews(footerStackView, collectPeronalInfoView)

        footerStackView.constrainBottomToBottomOf(view: view)
        footerStackView.constrainLeadingToLeadingOf(view: view)
        footerStackView.constrainTrailingToTrailingOf(view: view)
        
        
        collectPeronalInfoView.constrainTopToBottomOf(view: backStackView!)
        collectPeronalInfoView.constrainLeadingToLeadingOf(view: view)
        collectPeronalInfoView.constrainTrailingToTrailingOf(view: view)
        collectPeronalInfoView.constrainBottomToTopOf(view: footerStackView)
        
        actionBtn.setOnTapListener { [self] in
            let generatedPersonalInfo = self.collectPeronalInfoView.generateCreatePersonalRequest()
            if(generatedPersonalInfo == nil){
                ProgressHUD.showError("Check all Input Fields")
            }
            else{
                self.createPersonalRequest = generatedPersonalInfo
                 //Create the user here on Firebase
                attemptRegister()
            }
        }
        
        
        
        backStackView?.setOnTapListener {
            self.navigationController?.popViewController(animated: true)
        }
        
        func attemptRegister(){
            tAProgressHUD.show(on: view)
            Auth.auth().createUser(withEmail: createPersonalRequest?.email ?? "", password: createPersonalRequest?.password ?? "") { (result, err) in
                                        // Check for errors
                                      if err != nil {
                                          // There was an error creating the user
                                          self.showDismissableAlert(
                                              title: "Register Failed",
                                              msg: "Unable to register the user at this time.",
                                              actionTitle: "Try Again",
                                              alertAction: attemptRegister
                                          )
                                      }else {
                                          let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                          changeRequest?.displayName = self.createPersonalRequest?.fullName
                                          changeRequest?.commitChanges(completion: { (error) in
                                              if let error = error {
                                                  print(error.localizedDescription)
                                                  self.showDismissableAlert(title: "Register Failed", msg: "Unable to register the user at this time.")
                                              }
                                              
                                              
                                              self.tAProgressHUD.dismiss()
                                              
                                              guard let navigationController = self.navigationController else {return}
                                              self.showSuccessAlert(
                                                  title: "Your Account has been created successfully",
                                                  msg: "You now have accesss to be a CdKnight."
                                              )
                                              
                                              navigationController.popViewController(animated: true)
                                            
                                          })
                                      }
            }
        }
    }

    
}
