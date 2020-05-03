//
//  UserProfileVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout,UserProfileHeaderDelegate{
    
//  MARK: Properties
//    var currentUser: User?
//    var userToLoadFromSearchVC: User?
    var user:User?
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Register cell classes
        self.collectionView!.register(UserPostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // resgiter header class before use
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerIdentifier)
        // back ground color
        self.collectionView?.backgroundColor = .white

        //fetch user data
        if self.user == nil{
            fetchCurrentUserData()
        }
        // fetch post
         fetchPosts()
       
    }

    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    
    }
    
    // config size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: view.frame.width, height: 200)
    }


    
    // MARK: UICollectionView
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        
        return posts.count
//        return 10
    }
    

    
  
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

           // Declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
           
        // set delegate
        header.delegate = self // self ở đây là

//        if let user = self.user {
//            header.user = user
//        } else if let userToLoadFromSearchVC = self.user {
//            header.user = userToLoadFromSearchVC
//            self.navigationItem.title = userToLoadFromSearchVC.username
//
//        }
        if let user = self.user {
            header.user = user
            self.navigationItem.title = user.username
        }
        // Return header
        
           return header
       }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let feedVC = FeedVC(collectionViewLayout: UICollectionViewFlowLayout())
        feedVC.viewSinglePost = true
        feedVC.post = posts[indexPath.item]
        
        navigationController?.pushViewController(feedVC, animated: true)
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPostCell
    
        cell.post = posts[indexPath.item]
        // Configure the cell ( each item in collectionview )
     
        return cell
    }
//    MARK: UserProfileHeader Protocol
      
          func handleEditFollowTapped(for header: UserProfileHeader) {
             
             guard let user = header.user else { return }

             if header.editProfileFollowButton.titleLabel?.text == "Edit Profile" {
                                print("Handle edit profile")
//
//                 let editProfileController = EditProfileController()
//                 editProfileController.user = user
//                 editProfileController.userProfileController = self
//                 let navigationController = UINavigationController(rootViewController: editProfileController)
//                 present(navigationController, animated: true, completion: nil)

             } else {
                 // handles user follow/unfollow
                 if header.editProfileFollowButton.titleLabel?.text == "Follow" {
                     header.editProfileFollowButton.setTitle("Following", for: .normal)
                     user.follow()
                 } else {
                     header.editProfileFollowButton.setTitle("Follow", for: .normal)
                     user.unfollow()
                 }
             }
    }

        
        func setUserStats(for header: UserProfileHeader) {
                guard let uid = header.user?.uid else { return}
            
                         var numberOfFollowers: Int!
                         var numberOfFollowing: Int!
            
                         //get number of Followers
                         USER_FOLLOWER_REF.child(uid).observe(.value){ (snapshot) in
                             if let snapshot = snapshot.value as? Dictionary<String,AnyObject>{
                                 numberOfFollowers  = snapshot.count
                             }else{
                                 numberOfFollowers = 0
                             }
            
                             let attributedText = NSMutableAttributedString(string:"\(numberOfFollowers!)\n",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
                               attributedText.append(NSAttributedString(string:"followers",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
                             header.followersLabel.attributedText = attributedText
                         }
            
                         //get number of Following
                            USER_FOLLOWING_REF.child(uid).observe(.value){ (snapshot) in
                                if let snapshot = snapshot.value as? Dictionary<String,AnyObject>{
                                    numberOfFollowing  = snapshot.count
                                }else{
                                    numberOfFollowing = 0
                                }
                             let attributedText = NSMutableAttributedString(string:"\(numberOfFollowing!)\n",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
                                      attributedText.append(NSAttributedString(string:"following",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
                             header.followingLabel.attributedText = attributedText
            
                            }
        }
        
        func handleFollowersTapped(for header: UserProfileHeader) {
                let followVC = FollowVC()
            followVC.viewFollowers = true
            followVC.uid = user?.uid
            navigationController?.pushViewController(followVC, animated: true)
        }
        
        func handleFollowingTapped(for header: UserProfileHeader) {
              let followVC = FollowVC()
            followVC.viewFollowing  = true
            followVC.uid = user?.uid
            navigationController?.pushViewController(followVC, animated: true)

        }
    
    
    
    
    // MARK: API, get userData from DB
    func fetchPosts(){
        
        var uid:String!
        if let user = self.user {
            uid = user.uid
            
        }else{
            uid = Auth.auth().currentUser?.uid
        }
        
        USER_POSTS_REF.child(uid).observe(.childAdded) { (snapshot) in
                
            let postId = snapshot.key
            Database.fetchPost(with: postId) { (post) in
                self.posts.append(post)
                // sap xep list post
                self.posts.sort { (post1, post2) -> Bool in
                return post1.creationDate > post2.creationDate}
  //            print("Caption is:",post.caption)
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func fetchCurrentUserData(){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
             
             Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value){
                       (snapshot) in
                           print(snapshot)// snapshot la du lieu tren server gui ve
                       
                 guard let dictionaryData = snapshot.value as? Dictionary<String,AnyObject> else {return}
                 let uid = snapshot.key
                 let userData = User(uid: uid, dictionary: dictionaryData)
                 self.user = userData
                
                // Set navigationItem
               
                 self.navigationItem.title = userData.username
                self.collectionView?.reloadData()
                

              }
        
        
      
    }
 

}
