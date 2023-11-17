//
//  MenuViewController.swift
//  CDL
//
//  Created by Ayodeji Olalekan on 17/11/2023.
//

import UIKit

protocol MenuViewControllerDelegate : AnyObject {
    func didSelect(menuItem : MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate : MenuViewControllerDelegate?
    
    enum MenuOptions : String, CaseIterable{
        case Home = "Home"
        case Logout = "Logout"
        
        var imageName : String{
            switch self{
            case .Home:
                return "house"
            case .Logout:
                return "airplane"
            }
        }
    }
    
    private let tableView : UITableView = {
       let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate  = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .orange100()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
        
    }
    
    //Table view functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .baseWhite()
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .baseWhite()
        cell.backgroundColor = .orange100()
        cell.contentView.backgroundColor = .orange100()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }


}
