//
//  DetailVC.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/13/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        //profileImageView.image = user.image
        nicknameLabel.text = "Username: \(user.login)"
        emailLabel.text = "email: \(user.email ?? "no email")"
        followersLabel.text = "Followers: \(user.followers)"
        dateLabel.text = "Date: \n\(user.date)"
    }

}
