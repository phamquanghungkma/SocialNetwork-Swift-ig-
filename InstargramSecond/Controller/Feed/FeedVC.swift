//
//  FeedVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout,FeedCellDelegate {
 
  // MARK : - properties
    
    var posts = [Post]()
    var viewSinglePost = false
    var post:Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.backgroundColor = .white


        // Register cell classes
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        // configure refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        //configure loggout button
        configureNavigationBar()
        
        // call fetch api function
        if !viewSinglePost{
            fetchPosts()
        }
    }
    
    // MARK:- UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height  = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
    

    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if viewSinglePost {
            return 1
        }else {
            return posts.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        
        cell.delegate = self
        
        if viewSinglePost{
            if let post = self.post{
                cell.post = post
            }
        }else{
            cell.post = posts[indexPath.item]
        }
        
        // Configure the cell
    
        return cell
    }
    
    // MARK: FeedCellDelegate protocol
    func handleUsernameTapped(for cell: FeedCell) {
        
        guard let post = cell.post else {return}
        
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileVC.user = post.user
        
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
     
     func handleOptionsTapped(for cell: FeedCell) {
         print("handle options tapped")

     }
    
     
     func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool) {
         print("handle like tapped")

     }
     
     func handleCommentTapped(for cell: FeedCell) {
         print("handle comment tapped")

     }
    
    
    // MARK: handlers
    func configureNavigationBar(){
        
        if !viewSinglePost{
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Loggout", style: .plain, target: self, action: #selector(handleLoggout))
                
        }
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send"), style:.plain, target: self, action:#selector(handleShowMessages))
        
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send2"), style:.plain, target: self, action:#selector(handleShowMessages))
        
        self.navigationItem.title = "Feed"
    }
    
    @objc func handleRefresh(){
        posts.removeAll(keepingCapacity: false)
        fetchPosts()
        collectionView.reloadData()
        
    }
    
    @objc func handleShowMessages(){
        
        print("Handle show message")
    }
    
    @objc func handleLoggout(){
        
        // declare alert controllers
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //add alert to log out action
        alertControler.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                // atemp to sign out
                
                try Auth.auth().signOut()
                
                // present login controller
                let loginVC  = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController,animated:true,completion: nil)
                
                print("Successfully log out")
                
            } catch{
                
                // handler error
                print("Failed to sign out ")
            }
            
        }
            
        ))
        
        // add cancel action
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertControler,animated:true,completion:nil)
    }
    //MARK: -API
    func updateUserFeeds(){
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        USER_FOLLOWING_REF.child(currentUid).observe(.childAdded) { (snapshot) in
            let followingUserId = snapshot.key
            USER_POSTS_REF.child(followingUserId).observe(.childAdded) { (snapshot) in
                let postId = snapshot.key
                USER_FEED_REF.child(currentUid).updateChildValues([postId:1])
            }
        }
        USER_POSTS_REF.child(currentUid).observe(.childAdded) { (snapshot) in
                let postId = snapshot.key
            USER_FEED_REF.child(currentUid).updateChildValues([postId:1])
        }
        
    }
    
    func fetchPosts(){
        print("fecht posst function is called!")
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        USER_FEED_REF.child(currentUid).observe(.childAdded) { (snapshot) in

            let postId = snapshot.key
            Database.fetchPost(with: postId) { (post) in
                
                self.posts.append(post)
                 // sap xep list post
                 self.posts.sort { (post1, post2) -> Bool in
                 return post1.creationDate > post2.creationDate
                    
                }
                // stop refreshing
                self.collectionView.refreshControl?.endRefreshing()
                
                
                 //  print("Caption is:",post.caption)
                self.collectionView.reloadData()
            }
        }
    }
    
}
