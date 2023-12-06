//
//  MessageChatTableViewCell.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 31/07/23.
//

import UIKit

class MessageChatTableViewCell: UITableViewCell {
    //MARK: IBOUTLETS
    @IBOutlet weak var messageBackgroundView:UIView!
    @IBOutlet weak var messagelbl:UILabel!
//    @IBOutlet weak var timeLabel:UILabel!
    var trailingConstrainst:NSLayoutConstraint!
    var leadingConstraints:NSLayoutConstraint!

    //MARK: ViewLifeCycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        messagelbl.text = nil
        trailingConstrainst.isActive = false
        leadingConstraints.isActive = false
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
//MARK: Class Methods
extension MessageChatTableViewCell{
    func updateMessageCell( message: MessageData){
        messageBackgroundView.layer.cornerRadius = 16
        messageBackgroundView.clipsToBounds = true
        trailingConstrainst = messageBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        leadingConstraints = messageBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        messagelbl.text = message.message
        if message.isFirstSender{
            messageBackgroundView.backgroundColor = UIColor(red: 52/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1)
            trailingConstrainst.isActive = true
//            messagelbl.textAlignment = .right
        }else{
            messageBackgroundView.backgroundColor = UIColor(red: 83/255.0, green: 167/255.0, blue: 93/255.0, alpha: 1)
            leadingConstraints.isActive = true
            messagelbl.textAlignment = .left
        }
    }
}
