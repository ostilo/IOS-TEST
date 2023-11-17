//
//  TABackViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class TABackViewController: UIViewController {
    
    var backStackView: BackStackView?
    
    var wasPresented: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
        backStackView = addBackView()
    }
    
    func addBackView() -> BackStackView{
        let backView = BackStackView()
        view.addViews(backView)
        backView.constrainTopToTopSafeAreaOf(view: view, 12)
        backView.constrainLeadingToLeadingOf(view: view, 24)
        backView.setOnTapListener {
            self.close()
        }
        
        return backView
    }
    
    func close(){
        if wasPresented {
            dismiss(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

