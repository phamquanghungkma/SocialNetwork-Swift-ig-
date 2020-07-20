//
//  CommentCell.swift
//  InstargramSecond
//
//  Created by Apple on 6/15/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment?{
        // didSet is property observe
        didSet{
            
            guard let user = comment?.user  else { return }
            guard let profileImageUrl = user.profileImageUrl else { return }
            guard let username = user.username else { return }
            guard let commentText = comment?.commentText else  { return }
            
            
            let attributedText = NSMutableAttributedString(string:"\(username) :",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string:" \(commentText)",attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.black]))
            
                // time
            attributedText.append(NSAttributedString(string:" 2d",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
            
            commentTextView.attributedText = attributedText
            
            profileImageView.loadImage(with: profileImageUrl)
        }
    }
    
    
    let  profileImageView : CustomImageView  = {
           let iv = CustomImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.backgroundColor = .lightGray
           return iv
           
       }()
        
    let commentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
                  
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom:bottomAnchor , right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
        commentTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        addSubview(seperatorView)
//        seperatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 60, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
