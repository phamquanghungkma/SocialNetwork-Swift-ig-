//
//  MainTabVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/11/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        self.delegate = self
        
        //configure view controllers
        configureViewControllers()
        
        //user validation
        checkIfUserIsLoggedIn()
        
        
    }
    // function to create view controllers that exist within tab bar controller
    func configureViewControllers(){
        // home feed controller
        let feedVC = constructNavController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //search feed controller
        let searchVC = constructNavController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!,rootViewController: SearchVC())
        
        //post controller
        let uploadPostVC = constructNavController(unselectedImage: UIImage(named:"plus_unselected")!, selectedImage:  UIImage(named:"plus_unselected")!, rootViewController: UploadPostVC())
        
        // notification controller
        let notificationVC = constructNavController(unselectedImage: UIImage(named:"like_unselected")!, selectedImage: UIImage(named:"like_selected")!, rootViewController: NotificationsVC() )
        
        // profile controller
        let userProfileVC = constructNavController(unselectedImage: UIImage(named:"profile_unselected")!, selectedImage: UIImage(named:"profile_selected")!, rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        //view controller to be added to tab controller
        viewControllers = [feedVC,searchVC,uploadPostVC,notificationVC,userProfileVC]
        
        //tab bar tinit color
        tabBar.tintColor = .black
    }
    // construct navigation controller
    func constructNavController(unselectedImage:UIImage,selectedImage:UIImage,rootViewController:UIViewController = UIViewController())->UINavigationController{
        // construc nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        return navController
        // everytime we call this fucntion, it's going to return a navigation controller with whatever we set 
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                // present login controller
                let loginVC  = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController,animated:true,completion: nil)
            }
            
                    return
            
        }
        else {
            print("User is logged in")
        }
    }

   

}
