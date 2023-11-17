//
//  ContainerViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import UIKit

class ContainerViewController : UIViewController{
    
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menustate : MenuState = .closed
    
    var menuVC = MenuViewController()
    var homeVC = HomeViewController()
    var navVc : UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background()
        addChildVCs()
    }
    
    func addChildVCs(){
        //Add the Menu First and then the Home on-top of it.
        
        menuVC.delegate = self
        
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        
        homeVC.delegate = self
        
        let navVc = UINavigationController(rootViewController: homeVC)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        
        self.navVc = navVc
    }
    
    func accountLogout(){
        self.showDismissableAlert(
            title: "Are you sure you want to Log out?",
            actionTitle: "Log out",
            alertAction: self.attemptToLogUserOut
        )
    }
    private func attemptToLogUserOut(){
        Config.logUserOut()
        self.dismiss(animated: true)
    }
}


extension ContainerViewController : HomeViewControllerDelegate{
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion : (() -> Void)? ){
        switch menustate{
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:
                    .curveEaseInOut) {
                        self.navVc?.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
                        
                    } completion: {[weak self] done in
                        if(done){
                            self?.menustate = .opened
                            
                            
                            
                        }
                    }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:
                    .curveEaseInOut) {
                        
                        self.navVc?.view.frame.origin.x = 0
                        
                    } completion: {[weak self] done in
                        if(done){
                            self?.menustate = .closed
                            DispatchQueue.main.async {
                                completion?()
                            }
                        }
                    }
            
            break
        }
    }
}

extension ContainerViewController : MenuViewControllerDelegate{
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem{
        case .Home:
            break
        case .Logout:
            accountLogout()
            break
        }
    }
}
