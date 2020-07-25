//
//  NotificationsVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
private let reuseIdentifer = "NotificationCell"

class NotificationsVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clear seperator lines
        tableView.separatorColor = .clear
        // register cell
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifer)

    
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifer , for: indexPath) as! NotificationCell
        return cell
    }

 


   


}
