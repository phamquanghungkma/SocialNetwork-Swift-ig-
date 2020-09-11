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
class NotificationsVC: UITableViewController, NotificationCellDelegate {
    
    
    // MARK: Properties
    var notifications = [Notification]()
    var timer : Timer?
    

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // click vao 1 dong se chuyen sang trang ca nhan cua nguoi gui notification
        let notification = notifications[indexPath.row]
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.user = notification.user
        navigationController?.pushViewController(userProfileVC, animated: true)
    }

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
        cell.delegate = self
        return cell
    }
    
    // MARK: NotificationCellDelegate Protocol
    func handleFollowTapped(for cell: NotificationCell) {
        guard let  user =  cell.notification?.user else { return }
        if user.isFollowed {
            user.unfollow()
            cell.followButton.setTitle("Follow", for: .normal)
            cell.followButton.setTitleColor(.white, for: .normal)
            cell.followButton.layer.borderWidth = 0
            cell.followButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        } else {
            user.follow()
            cell.followButton.setTitle("Following", for: .normal)
            cell.followButton.setTitleColor(.black, for: .normal)
            cell.followButton.layer.borderWidth = 0.5
            cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
            cell.followButton.backgroundColor = .white
            
        }
        
    }
    
    func handlePostTapped(for cell: NotificationCell) {
        guard let post = cell.notification?.post else { return }
        
        let feedController = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
        feedController.viewSinglePost = true // day la trang ca nhan
        feedController.post = post
        navigationController?.pushViewController(feedController, animated: true)
        
    }
    
    // MARK : -Handlers
    
    func handleReloadTable(){
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleSortNotifications), userInfo: nil, repeats: false)
    }
    @objc func printSuper(){
        print("Timer is running ")
    }
    
    
    @objc func handleSortNotifications(){
        self.notifications.sort { (notification1, notification2) -> Bool in
            return notification1.creationDate > notification2.creationDate
        }
        self.tableView.reloadData()
        
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
                        self.handleReloadTable()
                    }
                } else {
                    let notification = Notification(user: user, dictionary: dictionary)
                    self.notifications.append(notification)
                    self.handleReloadTable()

                }

            }

        }

    }
}
