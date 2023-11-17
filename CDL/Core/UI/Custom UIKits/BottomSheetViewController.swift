//
//  BottomSheetViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 16/11/2023.
//

import UIKit

class BottomSheetViewController: UIViewController {

    private lazy var closeImg: UIImageView = {
        let img = UIImage.close().withPadding(top: 10, left: 10, bottom: 10, right: 10).imageView()
        img.constrainWidthTo(44)
        img.constrainHeightTo(44)
        img.setOnTapListener {
            self.dismiss(animated: true)
        }
        return img
    }()
    
    private lazy var statusImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.constrainHeightTo(80)
        imgView.constrainWidthTo(80)
        return imgView
    }()
    private lazy var statusImgContainerView: UIView = {
        let view = UIView()
        view.addViews(statusImgView)
        
        statusImgView.constrainTopToTopOf(view: view)
        statusImgView.constrainBottomToBottomOf(view: view)
        statusImgView.constrainToCenterXOf(view: view)
        
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel.displayXSBold()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    private lazy var captionLbl: UILabel = {
        let lbl = UILabel.textSMRegular()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    var contentView: UIView?
    var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 32
        
        if let statusImage = statusImage {
            statusImgView.image = statusImage
            stackView.addArrangedSubview(statusImgContainerView)
        }
        if let title = bottomSheetTitle {
            titleLbl.text = title
            stackView.addArrangedSubview(titleLbl)
        }
        if let caption = caption {
            captionLbl.text = caption
            stackView.addArrangedSubview(captionLbl)
        }
        if let contentView = contentView {
            stackView.addArrangedSubview(contentView)
        }
        stackView.addArrangedSubview(buttonsStackView)
        return stackView
    }()
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.roundTopCorners()
        view.backgroundColor = .baseWhite()
        view.addViews(contentStackView, closeImg)
        
        closeImg.constrainTopToTopOf(view: view, 14)
        closeImg.constrainTrailingToTrailingOf(view: view, 14)
        
        contentStackView.constrainTopToTopOf(view: view, 48)
        contentStackView.constrainBottomToBottomOf(view: view, 32)
        contentStackView.constrainLeadingToLeadingOf(view: view, 20)
        contentStackView.constrainTrailingToTrailingOf(view: view, 20)
        
        return view
    }()
    
    private lazy var tapToDismissView: UIView = {
        let view = UIView()
        view.setOnTapListener {
            self.dismiss(animated: true)
        }
        return view
    }()
    
    var statusImage: UIImage?
    var caption: String?
    var bottomSheetTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addViews(tapToDismissView, bottomSheetView)
        bottomSheetView.constrainBottomToBottomOf(view: view)
        bottomSheetView.constrainLeadingToLeadingOf(view: view)
        bottomSheetView.constrainTrailingToTrailingOf(view: view)
        
        tapToDismissView.constrainTopToTopOf(view: view)
        tapToDismissView.constrainLeadingToLeadingOf(view: view)
        tapToDismissView.constrainTrailingToTrailingOf(view: view)
        tapToDismissView.constrainBottomToTopOf(view: bottomSheetView)

        // Do any additional setup after loading the view.
    }
    
    func addActionBtn(title: String, isFilled: Bool = true, filledColor: UIColor = UIColor.orange100(), actionToPerform: @escaping () -> Void){
        let actionBtn: UIButton = {
            if isFilled {
                return .buttonFilled(title: title, backgroundColor: filledColor)
            }else{
                return .buttonStroke(title: title)
            }
        }()
        actionBtn.setTitle(title, for: .normal)
        actionBtn.setOnTapListener(action: actionToPerform)
        buttonsStackView.addArrangedSubview(actionBtn)
    }
    
    func addActionBtn(_ actionBtn: UIButton, actionToPerform: @escaping () -> Void){
        actionBtn.setOnTapListener(action: actionToPerform)
        buttonsStackView.addArrangedSubview(actionBtn)
    }
    
    static func generateBottomSheet(title: String? = nil, caption: String? = nil, statusImage: UIImage? = nil) -> BottomSheetViewController{
        let controller = BottomSheetViewController()
        controller.bottomSheetTitle = title
        controller.caption = caption
        controller.statusImage = statusImage
        controller.modalTransitionStyle = .coverVertical
        return controller
    }
    
}
