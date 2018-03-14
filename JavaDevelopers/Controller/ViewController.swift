//
//  ViewController.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/13/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var list = [User]()


    override func viewDidLoad() {
        super.viewDidLoad()
       
        // customize navigation bar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        //get list of url and user score
        Server.getJavaDevelopers (completion: { users in
            self.list += users ?? []
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        var user = list[indexPath.row]
        cell.usernameLabel.text = user.login
        cell.dateLabel.text = user.date
        
        if user.avatar == nil {
            Server.getUserAvatar(user, completion: {image in
                self.list[indexPath.row].avatar = image
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        cell.profileImageView.image = user.avatar
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailVC
                destinationController.user = list[indexPath.row]
            }
        }
    }

}

