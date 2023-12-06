//
//  profileSectionTableViewCell.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 28/07/23.
//

import UIKit

class profileSectionTableViewCell: UITableViewCell {
    //MARK: IBOUTLETS
    @IBOutlet weak var profilePictureImageView:UIImageView!
    @IBOutlet weak var qRCodePictureImageView:UIImageView!
    @IBOutlet weak var namelbl:UILabel!
    @IBOutlet weak var statuslbl:UILabel!
    
    //MARK: Variables
    static let identifier = "profileSectionTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    static func nib()-> UINib{
        return UINib(nibName: "profileSectionTableViewCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureProfileImage(with imageName:String){
        
        profilePictureImageView.layer.cornerRadius = 32
        profilePictureImageView.image = UIImage(named:imageName)
    }
    func configureQRImage(with imageName:String){
        qRCodePictureImageView.layer.cornerRadius = 16
        qRCodePictureImageView.image = UIImage(systemName:imageName)
    }
    
}
