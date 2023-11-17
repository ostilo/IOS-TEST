//
//  UIViewController+Extensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIViewController{
    
    func showDismissableAlert(title: String? = nil, msg: String? = nil, actionTitle: String, alertAction: @escaping () -> Void, statusImage: UIImage = .actionWarning(), dismissTitle: String = "Dismiss"){
        let bottomSheet = BottomSheetViewController.generateBottomSheet(title: title, caption: msg, statusImage: .actionWarning())
        
        bottomSheet.addActionBtn(.buttonFilled(title: actionTitle, backgroundColor: .error()), actionToPerform: {
            bottomSheet.dismiss(animated: true)
            alertAction()
        })
        
        bottomSheet.addActionBtn(.buttonStroke(title: dismissTitle, backgroundColor: .baseWhite(), strokeColor: .brand5(), textColor: .brand5()), actionToPerform: {
            bottomSheet.dismiss(animated: true)
        })
        present(bottomSheet, animated: true)
    }
    
    
    func showDismissableAlert(title: String? = nil, msg: String? = nil, statusImage: UIImage = .actionWarning(), dismissTitle: String = "Dismiss"){
        let bottomSheet = BottomSheetViewController.generateBottomSheet(title: title, caption: msg, statusImage: .actionWarning())
        
        bottomSheet.addActionBtn(.buttonStroke(title: dismissTitle, backgroundColor: .baseWhite(), strokeColor: .brand5(), textColor: .brand5()), actionToPerform: {
            bottomSheet.dismiss(animated: true)
        })
        present(bottomSheet, animated: true)
    }
    
    func showSuccessAlert(title: String? = nil, msg: String? = nil, dismissTitle: String = "Dismiss", btnColor: UIColor = .orange100(), statusImage: UIImage = .success()){
        let bottomSheet = BottomSheetViewController.generateBottomSheet(title: title, caption: msg, statusImage: statusImage)
        
        bottomSheet.addActionBtn(.buttonFilled(title: dismissTitle, backgroundColor: btnColor), actionToPerform: {
            bottomSheet.dismiss(animated: true)
        })
        
        present(bottomSheet, animated: true)
    }
    
}
