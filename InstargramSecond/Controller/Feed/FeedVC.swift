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

class FeedVC: UICollectionViewController {

    
    // MARK : - properties
    override func viewDidLoad() {
        super.viewDidLoad()


        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //configure loggout button
        configureLogoutButton()
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    // MARK: handlers
    func configureLogoutButton(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Loggout", style: .plain, target: self, action: #selector(handleLoggout))
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
    
}
