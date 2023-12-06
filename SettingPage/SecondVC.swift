//
//  SecondVC.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 29/07/23.
//

import UIKit


class SecondVC: UIViewController {
    //MARK: IBOUTLETS
    @IBOutlet weak var messagesTable:UITableView!
    
    var userData = [["Elon Musk","Elon","HI","5:00"],["Narendra Modi","Modi","Kem Cho","6:45"],["Tim Cook","Tim","Hello","10:42"],["MS Dhoni","MS","How are you?","8:13"],["Virat kohli","VK","Done with Training :)","9:32"],["Rohit Sharma","RS","Winning the Cup? ","Mon"],["Joe Biden","Joe","Whatsapp Man","11:46"],["William","William","Yupp","12:57"],["Ram Charan","Ram","Nice","3:23"],["John","John","Hello John","4:23"]]
    var value: Int = -1
    var profileName = ""
    var profilePictureImageName = ""
   
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsHeader()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(value)
        navigationController?.isNavigationBarHidden = false
        messagesTable.reloadData()
    }
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatSegue" {
            if let destVC = segue.destination as? ThirdVC {
//                destVC.lastMessages = { [weak self] str,value1 in
//                    self?.userData[value1][2] = str
//                }
                destVC.value = value
                destVC.nameText = profileName
                destVC.imageName = profilePictureImageName
            }
        }
    }
}
//MARK: Private Methods
extension SecondVC{
    private func initialSetup(){
       
        chatsHeader()
    }
    private func chatsHeader(){
        let chatsHeader = UIView(frame: CGRect(x:0, y:0, width:messagesTable.frame.width, height: 100))
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        let unreadImage = UIImageView()
        chatsHeader.addSubview(unreadImage)
        unreadImage.image = UIImage(systemName: "line.3.horizontal.decrease")
        let broadCastLabel = UILabel()
        broadCastLabel.text = "Broadcast Lists"
        broadCastLabel.textColor = .systemBlue
        broadCastLabel.font = UIFont.systemFont(ofSize: 16)
        let newGroupLbl  = UILabel()
        
        newGroupLbl.text = "New Group"
        newGroupLbl.textColor = .systemBlue
        newGroupLbl.font = UIFont.systemFont(ofSize: 16)
        newGroupLbl.textAlignment = .left
        chatsHeader.addSubview(newGroupLbl)
        chatsHeader.addSubview(broadCastLabel)
        chatsHeader.addSubview(searchBar)
        chatsHeader.addSubview(unreadImage)
        
        broadCastLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        unreadImage.translatesAutoresizingMaskIntoConstraints = false
        newGroupLbl.translatesAutoresizingMaskIntoConstraints = false
        newGroupLbl.trailingAnchor.constraint(equalTo: chatsHeader.trailingAnchor, constant: -10).isActive = true
        newGroupLbl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: chatsHeader.leadingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: unreadImage.leadingAnchor, constant: -10).isActive = true
        unreadImage.trailingAnchor.constraint(equalTo: chatsHeader.trailingAnchor, constant: -10).isActive = true
        searchBar.topAnchor.constraint(equalTo: chatsHeader.topAnchor, constant: 0).isActive = true
        unreadImage.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor, constant: 0).isActive = true
        unreadImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        unreadImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        broadCastLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14).isActive = true
        broadCastLabel.leadingAnchor.constraint(equalTo: chatsHeader.leadingAnchor, constant: 10).isActive = true
        
        messagesTable.tableHeaderView = chatsHeader
    }
}
//MARK: TableViewDelegate Methods
    extension SecondVC : UITableViewDelegate,UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MesssagesPageCell
            let userData = userData[indexPath.row]
            cell.profilePictureImageView.image = UIImage(named: userData[1])
            cell.profileName.text = userData[0]
            cell.profilePictureImageView.layer.cornerRadius = 32
            cell.lastMessage.text = userData[2]
            cell.timeLabel.text = userData[3]
            tableView.separatorInset = UIEdgeInsets(top: 0, left: cell.profilePictureImageView.frame.width + 16, bottom: 0, right: 0)
            tableView.separatorColor = .lightGray
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            profileName = userData[indexPath.row][0]
            profilePictureImageName = userData[indexPath.row][1]
            tableView.deselectRow(at: indexPath, animated: true)
            value = indexPath.row
            performSegue(withIdentifier: "chatSegue", sender: nil)
        }
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
                  self.userData.remove(at: indexPath.row)
                  tableView.beginUpdates()
                  tableView.deleteRows(at: [indexPath], with: .fade)
                  tableView.endUpdates()
                  completion(true)
              }
              deleteAction.image = UIImage(named: "ic_delete")
         deleteAction.backgroundColor = .red

              let moreAction = UIContextualAction(style: .normal, title: "More") { (action, view, completion) in
                
                  completion(true)
              }
              moreAction.image = UIImage(systemName: "ellipsis")
              moreAction.backgroundColor = .lightGray

              return UISwipeActionsConfiguration(actions: [deleteAction, moreAction])
          }

           func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              let pinAction = UIContextualAction(style: .normal, title: "Pin") { (action, view, completion) in
                  completion(true)
              }
              pinAction.image = UIImage(systemName: "pin.fill")
              pinAction.backgroundColor = .lightGray
              let unreadAction = UIContextualAction(style: .normal, title: "Unread") { (action, view, completion) in
                  completion(true)
              }
              unreadAction.image = UIImage(systemName: "envelope.badge")
              unreadAction.backgroundColor = .systemBlue

              return UISwipeActionsConfiguration(actions: [pinAction, unreadAction])
          }
      }
    
//MARK: TableViewCell Custom Class
class MesssagesPageCell:UITableViewCell{
    //MARK: IBOUTLETS
    @IBOutlet weak var profilePictureImageView:UIImageView!
    @IBOutlet weak var profileName:UILabel!
    @IBOutlet weak var lastMessage:UILabel!
    @IBOutlet weak var timeLabel:UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
      
    }
}

    
