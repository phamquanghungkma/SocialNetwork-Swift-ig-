//
//  NotificationsVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase
private let reuseIdentifer = "NotificationCell"
class NotificationsVC: UITableViewController {
    
    
    // MARK: Properties
    var notifications = [Notification]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clear seperator lines
        tableView.separatorColor = .clear
        // register cell
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifer)
        // fetch notification
        fetchNotifcation()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifer , for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        return cell
    }
    
    
    // MARK : - API
    func fetchNotifcation(){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        NOTIFICATIONS_REF.child(currentUid).observe(.childAdded) { (DataSnapshot) in
            guard let dictionary = DataSnapshot.value as?  Dictionary<String,AnyObject> else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            Database.fetchUser(with: uid) { (user) in
                    
                // if notification is for post
                if let postId = dictionary["postId"] as? String {
                    Database.fetchPost(with: postId) { (post) in
                        let notification = Notification(user: user, post: post, dictionary: dictionary)
                        self.notifications.append(notification)
                        self.tableView.reloadData()
                    }
                } else {
                    let notification = Notification(user: user, dictionary: dictionary)
                    self.notifications.append(notification)
                    self.tableView.reloadData()
                }
            }

        }

    }
}
