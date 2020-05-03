//
//  Post.swift
//  InstargramSecond
//
//  Created by Apple on 4/14/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import Foundation
class Post {
    
    var caption: String!
    var likes: Int!
    var imageUrl: String!
    var ownerUid:String!
    var creationDate: Date!
    var postId:String!
    var user: User?
    
    init(postId:String!,user: User,dictionary: Dictionary<String,AnyObject>) {
        self.postId = postId
        self.user = user
        
        if let caption = dictionary["caption"] as? String {
            self.caption = caption
        }
        if let likes = dictionary["likes"] as? Int {
            self.likes = likes
        }
        if let imageUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        if let ownerUid = dictionary["ownerUid"] as? String {
            self.ownerUid = ownerUid
        }
        if let creationDate = dictionary["creationDate"] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
        
    }
    
}
