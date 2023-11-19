//
//  HomeViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import UIKit
import RealmSwift

protocol HomeViewControllerDelegate : AnyObject {
    func didTapMenuButton()
}


class HomeViewController: UIViewController {
    var collectionview: UICollectionView!
    var token: NotificationToken?
    
    
    private lazy var headerDivider: UIView = {
        let view = UIView()
        view.constrainHeightTo(1)
        view.backgroundColor = .additionals2()
        return view
    }()
    
    
    private var transactions: [GetPostResponse] = []
    private lazy var tAProgressHUD = TAProgressHUD()
    
    
    
    private lazy var postRemote = PostRemote()
    weak var delegate : HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let realm = try! Realm()
        
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = .baseBlack()

        
        view.backgroundColor = .additionals1()
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),  style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .baseBlack()
        configurePostTableView()
        view.addViews(headerDivider, collectionview)
        
        
        
        headerDivider.constrainTopToTopOf(view: view, 16)
        headerDivider.constrainLeadingToLeadingOf(view: view)
        headerDivider.constrainTrailingToTrailingOf(view: view)
        
        collectionview.constrainTopToBottomOf(view: headerDivider, 16)
        collectionview.constrainLeadingToLeadingOf(view: view)
        collectionview.constrainTrailingToTrailingOf(view: view)
        collectionview.constrainBottomToBottomOf(view: view)
        
        getPostData()
        postObserver()
        
    }
    
    func postObserver(){
        
        var realmDb = try! Realm()
        //Get all the data from the database
        let notes = realmDb.objects(AllPostRetrived.self)
        /*If the fetched data is not empty then add it to model data array and update the UI */
        
        if(notes.count > 0)
        {
            //Clear the model data array to prevent duplicates
            self.transactions.removeAll()
            self.transactions = notes.first!.postList.toArray()
            
            
            self.collectionview.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    func getPostData(){
        tAProgressHUD.show(on: view)
        self.postRemote.getPostData(runCompletionOnUIThread: true){[weak self] (result) in
            guard let self = self else {return}
            tAProgressHUD.dismiss()
            switch result {
            case .success(let response):
                if response.isEmpty {
                    ProgressHUD.showError("No Post Yet")
                    return
                }else{
                    self.transactions = response
                }
                self.collectionview.reloadData()
            case .failure(_):
                ProgressHUD.showError("Could not fetch Business Categories")
            }
        }
    }
    
    func topViewController()-> UIViewController{
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        var topViewController:UIViewController = window!.rootViewController! // UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }
        return topViewController
    }
    
    func showShareActivity(_  msg:String?){
        var objectsToShare = [AnyObject]()
        
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        topViewController().present(activityVC, animated: true, completion: nil)
    }
    
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
    
    func configurePostTableView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection   = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize   = CGSize(width:view.frame.size.width, height: 60)
        
        collectionview  = UICollectionView(frame:.zero,collectionViewLayout: layout)
        guard let collectionView =  collectionview else {
            return
        }
        collectionView.isScrollEnabled =  true
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        collectionView.dataSource   = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionview)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  transactions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PostCollectionViewCell.identifier, for: indexPath) as!  PostCollectionViewCell
        cell.transaction = transactions[indexPath.row]
        if indexPath.row == transactions.count - 1{
            getPostData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let message = transactions[indexPath.row]
        showShareActivity("** Checkout this Post \n\n **" + (message.title ?? "") + "\n" + (message.body ?? ""));
    }
    
    
}
