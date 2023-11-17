//
//  TAProgressHUD.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit
import Lottie

public class TAProgressHUD{
    
    private static var hudView: ProgressHUDView?
    private var hudsView: ProgressHUDView?
    
    public static func show(on view: UIView? = nil) {
        
        let windows = UIApplication.shared.connectedScenes.flatMap({
            ($0 as? UIWindowScene)?.windows ?? []
        })
        
        guard let window = windows.first(where: {$0.isKeyWindow}) else {return}
        
        let baseView = view ?? window
        if let hudView = hudView, baseView.subviews.contains(hudView) {
            // view already exists on screen
            return
        }
        
        hudView = ProgressHUDView()
        
        guard let existingHudView = hudView else {
            return
        }
        
        existingHudView.frame = baseView.bounds
        baseView.addSubview(existingHudView)
        
        existingHudView.startAnimating()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                // gradually apply the blur effect
                existingHudView.effect = UIBlurEffect(style: .extraLight)
            }
        }
    }
    
    public func show(on view: UIView? = nil) {
        
        let windows = UIApplication.shared.connectedScenes.flatMap({
            ($0 as? UIWindowScene)?.windows ?? []
        })
        
        guard let window = windows.first(where: {$0.isKeyWindow}) else {return}
        
        let baseView = view ?? window
        if let hudView = hudsView, baseView.subviews.contains(hudView) {
            // view already exists on screen
            return
        }
        
        hudsView = ProgressHUDView()
        
        guard let existingHudView = hudsView else {
            return
        }
        
        existingHudView.frame = baseView.bounds
        baseView.addSubview(existingHudView)
        
        existingHudView.startAnimating()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                // gradually apply the blur effect
                existingHudView.effect = UIBlurEffect(style: .light)
            }
        }
    }
    
    public func dismiss() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.hudsView?.effect = nil
            }, completion: { _ in
                self.hudsView?.stopAnimating()
                self.hudsView?.removeFromSuperview()
                self.hudsView = nil
            })
        }
    }
    public static func dismiss() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.hudView?.effect = nil
            }, completion: { _ in
                self.hudView?.stopAnimating()
                self.hudView?.removeFromSuperview()
                self.hudView = nil
            })
        }
    }
}

// The view that overlays the window
private class ProgressHUDView: UIVisualEffectView {
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private let progressView: LottieAnimationView = {
        let view = LottieAnimationView(name: "CdlLoader")
        view.loopMode = .loop
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var progressContentView: UIView = {
        
        let size: CGFloat = 200
        let view = UIView()
        view.backgroundColor = .clear
        view.constrainHeightTo(size)
        view.constrainWidthTo(size)
        //        view.layer.cornerRadius = size / 2
        view.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        
        view.addSubview(progressView)
        progressView.constrainTopToTopOf(view: view)
        progressView.constrainBottomToBottomOf(view: view)
        progressView.constrainLeadingToLeadingOf(view: view)
        progressView.constrainTrailingToTrailingOf(view: view)
        
        return view
    }()
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.progressView.play()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.progressView.pause()
        }
    }
    
    private func setup() {
        contentView.addSubview(progressContentView)
        progressContentView.constrainToCenterYOf(view: self)
        progressContentView.constrainToCenterXOf(view: self)
    }
}
