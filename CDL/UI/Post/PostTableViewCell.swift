//
//  PostTableViewCell.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PostCollectionViewCell"
    let Let1 = ((UIScreen.main.bounds.width) );
    
    
        //square.and.arrow.up
    private lazy var flowImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "square.and.arrow.up")
        imgView.tintColor = .baseBlack()
        imgView.constrainHeightTo(20)
        imgView.constrainWidthTo(20)
        return imgView
    }()
    
    private lazy var flowImgContainer: UIView = {
        let view = UIView()
        view.cornerRadius = 5
        view.addViews(flowImgView)
        flowImgView.constrainTopToTopOf(view: view, 5)
        flowImgView.constrainLeadingToLeadingOf(view: view, 5)
        flowImgView.constrainTrailingToTrailingOf(view: view, 5)
        flowImgView.constrainBottomToBottomOf(view: view, 5)
        return view
    }()
    
    
    private lazy var transactionDescLbl: UILabel = {
        let lbl = UILabel.textSMRegular()
        lbl.adjustsFontSizeToFitWidth = false
        lbl.lineBreakMode = .byTruncatingTail
        lbl.numberOfLines = 1
        return lbl
    }()
   
   
    private lazy var amountLbl: UILabel = {
        let lbl = UILabel.textSMBold()
        
        lbl.adjustsFontSizeToFitWidth = false
        lbl.lineBreakMode = .byTruncatingTail
        lbl.numberOfLines = 1
        return lbl
    }()
    
    var transaction: GetPostResponse? {
        didSet {
            guard let transaction = transaction else {return}
            
            transactionDescLbl.text = transaction.title
            amountLbl.text = transaction.body
            amountLbl.textColor = .orange100()
            
        }
    }


    override init(frame: CGRect) {
          super.init(frame: frame)
          addViews()
      }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addViews(){
                contentView.backgroundColor = .white
                contentView.addViews(flowImgContainer, amountLbl, transactionDescLbl)
        
                flowImgContainer.constrainLeadingToLeadingOf(view: contentView, 24)
                transactionDescLbl.constrainLeadingToTrailingOf(view: flowImgContainer, 16)
                transactionDescLbl.constrainTopToTopOf(view: contentView, 18)
                transactionDescLbl.constrainTrailingToTrailingOf(view: contentView, 24)
                amountLbl.constrainTopToBottomOf(view: transactionDescLbl, 6)
                amountLbl.constrainLeadingToLeadingOf(view: transactionDescLbl)
                amountLbl.constrainTrailingToTrailingOf(view: contentView, 24)
                flowImgContainer.constrainTopToTopOf(view: contentView, 18)
    }
    
}



