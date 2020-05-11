//
//  FollowVC.swift
//  InstargramSecond
//
//  Created by Apple on 4/5/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifer = "FollowCell"

class FollowLikeVC : UITableViewController, FollowCellDelegate{

    
//    MARK: - Properties
    
    enum ViewingMode: Int {
          case Following
           case Followers
            case Likes
        init(index: Int ) {
            switch index {
            case 0: self = .Following
            case 1: self = .Followers
            case 2: self = .Likes
            default: self = .Following
            }
        }
        
    }
    
    
    var postId: String?
    var viewingMode: ViewingMode!
    var uid: String?
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cell class
        tableView.register(FollowLikeCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        // config nav controller and fetch user
        if let viewingMode = self.viewingMode {
            // set tittle
            configureNavigationTitle(with: viewingMode)
            // fetch users
            fetchUsers(by: self.viewingMode)

            
        }
        
        // clear seperator lines
        tableView.separatorColor = .clear
        
        print("Viewing mode integer value is ",viewingMode.rawValue)
        
        if let uid = self.uid {
            print("User id is \(uid)")
        }
        
    }
//    MARK: -UITableView
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        68
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! FollowLikeCell
        cell.user = users[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.user = user
        
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    //MARK: - FollowCellDelegate Protocol
    func handleFollowTapped(for cell: FollowLikeCell) {
                
        guard let user = cell.user else {return}
        if user.isFollowed {
            user.unfollow()
            
            cell.followButton.setTitle("Follow", for: .normal)
            cell.followButton.setTitleColor(.white, for: .normal)
            cell.followButton.layer.borderWidth = 0
            cell.followButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        }
        else{

            user.follow()
            
            cell.followButton.setTitle("Following", for: .normal)
            cell.followButton.setTitleColor(.black, for: .normal)
            cell.followButton.layer.borderWidth = 0.5
            cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
            cell.followButton.backgroundColor = .white
            
        }
    }
    
    // MARK: - Handlers
    func configureNavigationTitle(with viewingMode: ViewingMode){
        switch viewingMode {
        case .Followers: navigationItem.title = "Followers"
        case .Following: navigationItem.title = "Following"
        case .Likes : navigationItem.title = "Likes"
               }

    }
    
    // MARK: API
    func getDatabaseReference()-> DatabaseReference?{
        guard let viewingMode = self.viewingMode else { return nil }
        
        switch viewingMode {
        case .Followers:
            return USER_FOLLOWER_REF
        case .Following:
            return USER_FOLLOWING_REF
        case .Likes:
            return POST_LIKES_REF
        }
        
    }
    
    func fetchUsers(by viewingMode: ViewingMode){
        // tham số ViewingMode để truyền vào getDatabaseReference
        guard let ref = getDatabaseReference() else { return }
        
        switch viewingMode {
            
            case .Followers, .Following:
                guard let uid = self.uid else {return}

                ref.child(uid).observeSingleEvent(of: .value )  { (snapshot) in
                              
                      guard let allObject = snapshot.children.allObjects as? [DataSnapshot] else {return}
                      
                      allObject.forEach({ (snapshot) in
                          
                          let userId = snapshot.key
                          Database.fetchUser(with: userId, completion:{(user) in
                              self.users.append(user)
                              self.tableView.reloadData()
                              
                          })
                          
                      })
                  }
            case .Likes:
                guard let postId = self.postId else { return  }
//                guard let uid = self.uid else {return}

                print("id post is :", postId)
                print("duong dan la \(ref)")
                ref.child(postId).observe(.childAdded) { (snapshot) in
                    // lay dc id cua user tuc la uid
                    let uid = snapshot.key
                    Database.fetchUser(with: uid) { (user) in
                        self.users.append(user)
                        
                        self.tableView.reloadData()
                    }
            }
        
        }
        
        
      
      
    }
 
}
