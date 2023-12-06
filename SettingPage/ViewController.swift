//
//  ViewController.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 28/07/23.
//

import UIKit

class ViewController: UIViewController {
    //MARK: IBOUTLETS
    @IBOutlet weak var myTable:UITableView!
    
    //MARK: Variables
    let optionTitle : [[String]] = [["","Avatar"],["Starred Messages","Linked Devices"],["Account","Privacy","Chats","Notifications","Payments","Storage and Data"],["Help","Tell a Friend"]]
    let images : [[String]] = [["","ic_avatar"],["ic_square","ic_devices"],["ic_key-of-success","ic_document-lock ","ic_chat","ic_notification ","ic_rupee","ic_mobile-data"],["ic_information","ic_heart "]]
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
}
//MARK: Private Methods
extension ViewController{
    private func initialSetup(){
        view.backgroundColor = .systemGray5
        myTable.backgroundColor = .systemGray5
        myTable.register(profileSectionTableViewCell.nib(), forCellReuseIdentifier: profileSectionTableViewCell.identifier)
        myTable.register(OptionTableViewCell.nib(), forCellReuseIdentifier: OptionTableViewCell.identifier)
        myTable.delegate = self
        myTable.dataSource = self
        settingsHeader()
    }
    private func settingsHeader(){
        let settingsHeader = UIView(frame: CGRect(x:0, y:0, width:myTable.frame.width, height: 60))
        let searchBar = UISearchBar()

//        searchBar.backgroundColor = .lightGray
//        searchBar.layer.cornerRadius = 32
        searchBar.placeholder = "Search"
        searchBar.layer.borderColor = CGColor(gray: 0, alpha: 0)
        settingsHeader.addSubview(searchBar)
        searchBar.searchBarStyle = .minimal
       
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: settingsHeader.leadingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: settingsHeader.trailingAnchor, constant: -10).isActive = true
        
//        searchBar.topAnchor.constraint(equalTo: settingsHeader.topAnchor).isActive = true
//        searchBar.bottomAnchor.constraint(equalTo: settingsHeader.bottomAnchor).isActive = true
        myTable.tableHeaderView = settingsHeader
        myTable.tableHeaderView?.backgroundColor = .clear
    }
}
//MARK: TableViewDelegate Methods
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionTitle[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: profileSectionTableViewCell.identifier, for: indexPath) as! profileSectionTableViewCell
            cell.configureQRImage(with: "qrcode")
            cell.configureProfileImage(with: "ic_user")
            cell.namelbl.text = "Sreejith Warrier"
            cell.statuslbl.text = "At Work :("
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier, for: indexPath) as! OptionTableViewCell
            
            cell.namelbl.text = "\(optionTitle[indexPath.section][indexPath.row])"
            cell.iconImage.image = UIImage(named: "\(images[indexPath.section][indexPath.row])")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0){
            return 90
        }
        return 60
    }
    
}
