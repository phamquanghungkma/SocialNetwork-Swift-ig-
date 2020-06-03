//
//  Extensions.swift
//  InstargramSecond
//
//  Created by Apple on 2/3/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase


extension UIView{
    // this is a function
    func anchor(
        top:NSLayoutYAxisAnchor?,
        left:NSLayoutXAxisAnchor?,
        bottom:NSLayoutYAxisAnchor?,
        right:NSLayoutXAxisAnchor?,
        paddingTop:CGFloat,// gia tri
        paddingLeft:CGFloat,// gia tri
        paddingBottom:CGFloat,// gia tri
        paddingRight:CGFloat,// gia tri
        width:CGFloat,
        height:CGFloat
        ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}


extension Database {
    // extenstion cho Database cua Firebase
    // nhận vào uid, và thực thi completion
    static func fetchUser(with uid:String , completion: @escaping(User)->()){
        
        USER_REF.child(uid).observeSingleEvent(of: .value){
            (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            // truyen user vao completion block, thực hiện completion này
            completion(user)
        }
        
    }
    
    static func fetchPost(with postId:String, completion: @escaping(Post)->()){
        
        POSTS_REF.child(postId).observeSingleEvent(of: .value) { (snapshot) in
            
         guard let  dictionary = snapshot.value as? Dictionary<String,AnyObject> else {return}
         guard let ownerUid = dictionary["ownerUid"] as? String else {return}
            
            Database.fetchUser(with: ownerUid) { (user) in
                
                let post = Post(postId: postId, user: user, dictionary: dictionary)
                
                completion(post)
                
                
            }
            
        }
    }
}



