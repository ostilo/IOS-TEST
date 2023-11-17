//
//  UIView+Extenstions.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func constrainWidthTo(_ width: CGFloat){
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    @discardableResult
    func constrainHeightTo(_ height: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(equalToConstant: height)
        //        constraint.isActive = true
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    func constrainWidthToEqual(_ view: UIView){
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func constrainHeightToEqual(_ view: UIView){
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func addViews(_ views: UIView...){
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func constrainTopToTopOf(view: UIView, _ constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    
    func constrainTopToTopSafeAreaOf(view: UIView, _ constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
    }
    
    func constrainTopToBottomOf(view: UIView, _ constant: CGFloat = 0){
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    
    func constrainBottomToBottomOf(view: UIView, _ constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainBottomToTopOf(view: UIView, _ constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant).isActive = true
    }
    
    func constrainBottomToBottomSafeAreaOf(view: UIView, _ constant: CGFloat = 0){
        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainLeadingToLeadingOf(view: UIView, _ constant: CGFloat = 0) -> NSLayoutConstraint{
        //        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
        
        let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        constraint.isActive = true
        
        return constraint
    }
    
    func constrainLeadingToTrailingOf(view: UIView, _ constant: CGFloat = 0){
        self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant).isActive = true
    }
    
    func constrainTrailingToTrailingOf(view: UIView, _ constant: CGFloat = 0) -> NSLayoutConstraint{
        //        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        
        let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        constraint.isActive = true
        
        return constraint
    }
    
    func constrainTrailingToLeadingOf(view: UIView, _ constant: CGFloat = 0){
        self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant).isActive = true
    }
    
    func constrainToCenterYOf(view: UIView){
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func constrainToCenterXOf(view: UIView){
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func fillParentWithDefaultMargin(parent: UIView){
        self.constrainLeadingToLeadingOf(view: parent, 24)
        self.constrainTrailingToTrailingOf(view: parent, 24)
    }
    
    func fillParentWithMargin(parent: UIView,_ margin: CGFloat){
        self.constrainLeadingToLeadingOf(view: parent, margin)
        self.constrainTrailingToTrailingOf(view: parent, margin)
    }
    
    func setOnTapListener(action: @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        let recognizer = OnTap(target: self, action: #selector(onViewTapped(sender:)))
        recognizer.onClick = action
        self.addGestureRecognizer(recognizer)
    }
    
    @objc private func onViewTapped(sender: OnTap) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
    func roundTopCorners(radius: CGFloat = 20) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func roundBottomCorners(radius: CGFloat = 20) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func roundRightCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    func roundLeftCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func removeAndHide(){
        removeFromSuperview()
        isHidden = true
    }
    
    func customiseBorder(color: UIColor? = nil, width: CGFloat? = nil){
        if let color = color {
            layer.borderColor = color.cgColor
        }
        if let width = width {
            layer.borderWidth = width
        }
    }
    
}

private class OnTap: UITapGestureRecognizer {
    var onClick: (() -> Void)? = nil
}

