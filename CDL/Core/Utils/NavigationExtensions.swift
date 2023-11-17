//
//  NavigationExtensions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//
import UIKit

extension UIViewController {
    
    func isViewControllerInNavigationStack(_ viewControllerType: AnyClass) -> Bool {
        if let navigationController = self.navigationController {
            return navigationController.viewControllers.contains(where: { $0.isKind(of: viewControllerType) })
        }
        
        return false
    }
    
    func navigateBackTo(_ viewControllerType: AnyClass){
        guard let navigationController = navigationController else {return}
        for controller in navigationController.viewControllers as Array {
            if controller.isKind(of: viewControllerType) {
                navigationController.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func navigateTo(_ viewController: UIViewController, shouldFade: Bool = false){
        
        if shouldFade {
            let transition = CATransition()
            transition.duration = 0.3 // Set the duration of the fade-in animation
            transition.type = CATransitionType.fade
            navigationController?.view.layer.add(transition, forKey: kCATransition)
        }
        
        navigationController?.pushViewController(viewController, animated: !shouldFade)
    }
    
    func navigateOrGoBackTo(_ viewController: UIViewController){
        let controllerType = type(of: viewController)
        if isViewControllerInNavigationStack(controllerType) {
            navigateBackTo(controllerType)
        }else{
            navigateTo(viewController)
        }
    }
    
    func navigateBack(shouldFade: Bool = false) {
        if let navigationController = navigationController {
            if shouldFade {
                let transition = CATransition()
                transition.duration = 0.3 // Set the duration of the fade-in animation
                transition.type = CATransitionType.fade
                navigationController.view.layer.add(transition, forKey: kCATransition)
            }
            
            navigationController.popViewController(animated: !shouldFade)
        } else {
            dismiss(animated: true)
        }
        
    }
    
    @objc
    func navigateToSignup(){
        let controller: UIViewController = {
            return SignupViewController()
        }()
        
        navigateOrGoBackTo(controller)
    }
    
    @objc
    func navigateToLogin(){
        let controller: UIViewController = {
            return LoginViewController()
        }()
        
        navigateOrGoBackTo(controller)
    }
    
}

