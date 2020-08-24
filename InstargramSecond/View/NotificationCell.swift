//
//  NotificationCell.swift
//  InstargramSecond
//
//  Created by Apple on 7/20/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    //MARK : Properties
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    var notification: Notification? {
        didSet{
            guard let user = notification?.user else { return }
            guard let profileImageUrl = user.profileImageUrl else { return }
            profileImageView.loadImage(with: profileImageUrl)
            
            // config notification message
            configureNotificationLabel()
            
            configurNotificationType()
            guard let post = notification?.post else { return }
            print("post is : \(post)" )

            guard let postImageUrl = notification?.post?.imageUrl else { return }
//            if let post = notification?.post {
//                postImageView.loadImage(with: post.imageUrl)
//                print("imageURL : \(post.imageUrl)")
//            }
            print("image is : \(postImageUrl)" )
            postImageView.loadImage(with: postImageUrl)
            
        }
    }
    
    
    let notificationLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var followButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        
        return button
    }()
    
    let postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    //MARK: - Handlers
    @objc func handleFollowTapped(){
        print("Handle follow tapped")
    }
    
    func configurNotificationType(){
        guard let notification = self.notification else { return }
        guard let user = notification.user else { return }
        
        var anchor : NSLayoutXAxisAnchor!
        
        if notification.notificationType != .Follow {
            // notification type is comment or like
            // neu thong bao ve != follow thi sẽ hiển thị ảnh
            addSubview(postImageView)
                     postImageView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 40, height: 40)
                     postImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            anchor = postImageView.leftAnchor
        } else {
            // còn k thì sẽ tạo ra button
            // notification type is follow
            addSubview(followButton)
            followButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 90, height: 30)
            followButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            followButton.layer.cornerRadius = 3
            anchor = followButton.leftAnchor
        }
        addSubview(notificationLabel)
        notificationLabel.anchor(top: nil, left:  profileImageView.rightAnchor, bottom: nil, right: anchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
            notificationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    func configureNotificationLabel(){
        
        guard let notification = self.notification else { return }
        guard let user = notification.user else { return }
         let notificationMessage = notification.notificationType.description
        guard let username = user.username else { return }
        
        let attributedText = NSMutableAttributedString(string:username ,attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12)])
               
            attributedText.append(NSAttributedString(string: notificationMessage ,attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12)]))
            attributedText.append(NSAttributedString(string:"2d",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
        notificationLabel.attributedText = attributedText
         
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop:0 , paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 40/2

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
