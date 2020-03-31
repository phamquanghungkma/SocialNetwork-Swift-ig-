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
    var currentUser: User?
    var userToLoadFromSearchVC: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // resgiter header class before use
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerIdentifier)
        // back ground color
        self.collectionView?.backgroundColor = .white

        //fetch user data
        if userToLoadFromSearchVC == nil{
            fetchCurrentUserData()
        }
        
       
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return 0
    }
    

    
    // config size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

           // Declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        
        if let user = self.currentUser {
            header.user = user
        } else if let userToLoadFromSearchVC = self.userToLoadFromSearchVC {
            header.user = userToLoadFromSearchVC
            self.navigationItem.title = userToLoadFromSearchVC.username

        }
        // Return header
        
           return header
       }
 

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
     
        return cell
    }
//    MARK: handler
      
          func handleEditFollowTapped(for header: UserProfileHeader) {
             
    //         guard let user = header.user else { return }
    //
    //         if header.editProfileFollowButton.titleLabel?.text == "Edit Profile" {
    //
    //             let editProfileController = EditProfileController()
    //             editProfileController.user = user
    //             editProfileController.userProfileController = self
    //             let navigationController = UINavigationController(rootViewController: editProfileController)
    //             present(navigationController, animated: true, completion: nil)
    //
    //         } else {
    //             // handles user follow/unfollow
    //             if header.editProfileFollowButton.titleLabel?.text == "Follow" {
    //                 header.editProfileFollowButton.setTitle("Following", for: .normal)
    //                 user.follow()
    //             } else {
    //                 header.editProfileFollowButton.setTitle("Follow", for: .normal)
    //                 user.unfollow()
    //             }
    //         }
         }
        
        func setUserStats(for header: UserProfileHeader) {
            
        }
        
        func handleFollowersTapped(for header: UserProfileHeader) {
            
        }
        
        func handleFollowingTapped(for header: UserProfileHeader) {
            
        }
    
    
    
    
    // MARK: API, get userData from DB
    func fetchCurrentUserData(){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
             
             Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value){
                       (snapshot) in
                           print(snapshot)// snapshot la du lieu tren server gui ve
                       
                 guard let dictionaryData = snapshot.value as? Dictionary<String,AnyObject> else {return}
                 let uid = snapshot.key
                 let userData = User(uid: uid, dictionary: dictionaryData)
                 self.currentUser = userData
                
                // Set navigationItem
               
                 self.navigationItem.title = userData.username
                self.collectionView?.reloadData()
                

              }
        
        
      
    }
 

}
