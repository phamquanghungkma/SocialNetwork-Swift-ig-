//
//  SearchVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {

    
    //Mark : properties
    var users = [User]()// create an array user
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cell classesxs
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier )
        
        // separator insets
        tableView.separatorInset = UIEdgeInsets(top:0, left: 64, bottom:0 , right: 0)
        
        //configured nav controller
        configureNavController()
        
        
        fetchUsers()     // fetchUser
        
        print("When view loads user array count is \(users.count)")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Number of Rows is \(users.count)")
       
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = users[1]
        let user = users[indexPath.row]

        // event as touching an item
        print("Username is \(user.username)")
        // create  instance of user profile vc
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        // pass user from searchVC to userProfile
        userProfileVC.user = user
        
        //push view controll
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // hàm này sẽ chạy số lần tuỳ thuộc bao nhiêu phần tử của list,
        // ví dụ trong numberOfRowInSection return 5 thì hàm này sẽ chạy 5 lần 
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        
        cell.user = users[indexPath.row]
        // cell.user la truy cap den user property tai SearchUserCell.swift
        
        return cell
    }

//    MARK : handler
    func configureNavController(){
        navigationItem.title = "Explorer"
    }
    
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded){
            // lay het danh sach user trong database
            // snapshot du lieu gui ve
            (snapshot) in
            
            let uid = snapshot.key
            Database.fetchUser(with: uid, completion: { (user) in
                self.users.append(user)
                self.tableView.reloadData()
            })
            
       
            
        
    }
}
}
