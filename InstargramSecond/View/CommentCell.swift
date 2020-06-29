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
    
    let commentLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string:"tofu",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string:" some test comments ",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string:"2d",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
        
        label.attributedText = attributedText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
                  
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 48/2
        
        addSubview(commentLabel)
        commentLabel.anchor(top: nil, left: profileImageView.rightAnchor, bottom:nil , right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        commentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
