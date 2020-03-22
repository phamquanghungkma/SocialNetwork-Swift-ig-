//
//  User.swift
//  InstargramSecond
//
//  Created by Apple on 3/21/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

class User {
    //attributes
    var username: String!
    var name: String!
    var profileImage: String!
    var uid: String!
    
    init(uid: String, dictionary: Dictionary<String,AnyObject>){
        
        self.uid = uid
        if let username  = dictionary["username"] as? String {
            self.username = username
        }
        if let name  = dictionary["names"] as? String {
                   self.name = name
        }
        if let profileImage  = dictionary["profileImageURL"] as? String {
                   self.profileImage = profileImage
        }
       
        
    }
    
    
    
}
