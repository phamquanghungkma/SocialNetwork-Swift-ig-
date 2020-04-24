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

class FeedVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    
    // MARK : - properties
    
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.backgroundColor = .white


        // Register cell classes
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //configure loggout button
        configureNavigationBar()
        
        // call fetch api function
        fetchPosts()
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
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.post = posts[indexPath.row]
    
        // Configure the cell
    
        return cell
    }
    
    // MARK: handlers
    func configureNavigationBar(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Loggout", style: .plain, target: self, action: #selector(handleLoggout))
        
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send"), style:.plain, target: self, action:#selector(handleShowMessages))
        
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send2"), style:.plain, target: self, action:#selector(handleShowMessages))
        
        self.navigationItem.title = "Feed"
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
    
    func fetchPosts(){
        
        POSTS_REF.observe(.childAdded) { (snapshot) in

            let postId = snapshot.key
            
            guard let  dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            
            let post = Post(postId: postId, dictionary: dictionary)
            
            
            self.posts.append(post)
            
            // sap xep list post
            self.posts.sort { (post1, post2) -> Bool in
                return post1.creationDate > post2.creationDate
            }
//            print("Caption is:",post.caption)
            
            self.collectionView.reloadData()
            
        }
    }
    
}
