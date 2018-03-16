//
//  TableViewCell.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/13/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import UIKit

class DeveloperCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithUser(_ user: User) {
        usernameLabel.text = user.login
        dateLabel.text = user.date
        profileImageView.image = user.avatar
    }

}
