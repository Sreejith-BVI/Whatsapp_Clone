//
//  OptionTableViewCell.swift
//  SettingPage
//
//  Created by Sreejith Warrier on 28/07/23.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    //MARK: IBOUTLETS
    @IBOutlet weak var iconImage:UIImageView!
    @IBOutlet weak var namelbl:UILabel!
    
    //MARK: Variables
    static let identifier = "optionTableViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: "OptionTableViewCell", bundle: nil)
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
