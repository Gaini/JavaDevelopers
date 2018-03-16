//
//  ViewController.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/13/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import UIKit

class DevelopersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var page = 1
    let AmountBeforeLoadNext = 2


    override func viewDidLoad() {
        super.viewDidLoad()
       
        // customize navigation bar
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
               
        loadNextPage()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DeveloperCell
        
        let user = users[indexPath.row]
        cell.setupWithUser(user)
        
        if user.avatar == nil {
            Server.getUserAvatar(user, completion: {image in
                self.users[indexPath.row].avatar = image
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        
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
                let destinationController = segue.destination as! DeveloperDetailVC
                destinationController.user = users[indexPath.row]
            }
        }
    }

}

