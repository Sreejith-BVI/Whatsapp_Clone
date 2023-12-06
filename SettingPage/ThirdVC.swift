//
//  ThirdVC.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 29/07/23.
//

import UIKit

class ThirdVC: UIViewController {
    //MARK: IBOUTLETS
    @IBOutlet weak var messageTFT: UITextField!
    @IBOutlet weak var chatMessageTable: UITableView!
    @IBOutlet weak var profileNamelbl:UILabel!
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var customTitleView:UIView!
    @IBOutlet weak var sendBtn:UIButton!
    
    //MARK: Variables
    var messages:[MessageData] = []
    var isFirstUser:Bool = true
    var nameText = ""
    var imageName = ""
    var value = -1
    
    //MARK: ViewLifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "messageSegue"{
            if let destvc = segue.destination as? SecondVC{
                destvc.userData[value][2] = messages[messages.count - 1].message
            }
        }
    }
    
}
//MARK: Private Methods
extension ThirdVC{
    private func initialSetup(){
        chatMessageTable.delegate = self
        chatMessageTable.dataSource = self
        navigationController?.isNavigationBarHidden = false
        chatMessageTable.backgroundView = UIImageView(image: UIImage(named: "backgroundView"))
        chatMessageTable.backgroundView?.layer.opacity = 0.3
        
        let sendButton = UIButton()
        sendButton.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendBtnTap), for: .touchUpInside)
        messageTFT.rightViewMode = .whileEditing
        messageTFT.rightView = sendButton
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupNavBar()
    }
    func setupNavBar() {
        let leftBarBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.backward" ), style: .plain, target: nil, action: nil)
        leftBarBtn.action = #selector(chatsScreenNavigation)
        leftBarBtn.target = self
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageview.image = UIImage(named: imageName)
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 20
        imageview.layer.masksToBounds = true
        containView.addSubview(imageview)
        let left = UIBarButtonItem(customView: containView)
        
        let userView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let userName = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.5, height: 15))
        let userStatus = UILabel(frame: CGRect(x: 0, y: 17, width: UIScreen.main.bounds.width / 1.5, height: 15))
        userStatus.font = UIFont.systemFont(ofSize: 12)
        userStatus.textColor = .gray
        userName.text = nameText
        userStatus.text = "Online"
        userView.addSubview(userName)
        userView.addSubview(userStatus)
        let userInfoView = UIBarButtonItem(customView: userView)
        navigationItem.leftBarButtonItems = [leftBarBtn,left,userInfoView]
        let voiceCallBtn = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: nil, action: nil)
        let videoCallBtn = UIBarButtonItem(image: UIImage(systemName: "video"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [voiceCallBtn,videoCallBtn]
        }
    @objc func chatsScreenNavigation(){
       
        
        performSegue(withIdentifier: "messageSegue", sender: nil)
    }
//    func getTimeForLabel() -> String{
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        let minute = calendar.component(.minute, from: date)
//        let realTime = "\(hour):\(minute)"
//        return realTime
//    }
}
//MARK: IBAction Methods
extension ThirdVC{
    @objc func sendBtnTap(){
        guard let messageFromTFT = messageTFT.text else{return}
        if messageFromTFT != ""{
            messages.append(MessageData(message: messageFromTFT, isFirstSender: isFirstUser))
            chatMessageTable.beginUpdates()
            chatMessageTable.insertRows(at: [IndexPath.init(row: messages.count - 1, section: 0)], with: .fade)
            chatMessageTable.endUpdates()
            chatMessageTable.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .top, animated: true)
            isFirstUser = !isFirstUser
            messageTFT.text = nil
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize:NSValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) {
            print(keyboardSize)
            let keyboardHeight = keyboardSize.cgRectValue.height
            let bottomSpace = self.view.frame.height - (messageTFT.frame.origin.y + messageTFT.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 40
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
}


//MARK: TableViewDelegate Methods
extension ThirdVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageChatTableViewCell
        cell.updateMessageCell(message: messages[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
