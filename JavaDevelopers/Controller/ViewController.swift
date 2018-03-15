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
    var users = [User]()
    var page = 1
    let AmountBeforeLoadNext = 2
    


    override func viewDidLoad() {
        super.viewDidLoad()
       
        // customize navigation bar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        loadNextPage()
        
        //self-sizing cell
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadNextPage() {
        
        Server.getJavaDevelopers (fromPage: page, completion: { users in
            self.users += users ?? []
            self.tableView.reloadData()
            self.page += 1
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let user = users[indexPath.row]
        cell.usernameLabel.text = user.login
        cell.dateLabel.text = user.date
        
        if user.avatar == nil {
            Server.getUserAvatar(user, completion: {image in
                self.users[indexPath.row].avatar = image
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        cell.profileImageView.image = user.avatar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if indexPath.row == users.count - AmountBeforeLoadNext {
            loadNextPage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailVC
                destinationController.user = users[indexPath.row]
            }
        }
    }

}

