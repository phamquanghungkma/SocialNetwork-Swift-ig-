import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    let  profileImageView : UIImageView  = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Health Ledger"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        
        return label
    }()
    let postLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string:"5\n",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string:"posts",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let followersLabel: UILabel = {
         let label = UILabel()
          label.numberOfLines = 0
          label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string:"5\n",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
             
        attributedText.append(NSAttributedString(string:"followers",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
             label.attributedText = attributedText
          
          return label
      }()
    let followingLabel: UILabel = {
           let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string:"5\n",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string:"following",attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
                    label.attributedText = attributedText
            
            return label
        }()
    
    let editProfileButton : UIButton = {
        let button  = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        
           return button
    }()
    
    let gridButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()
    
    let listButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    let  bookmarkButton : UIButton = {
          
          let button = UIButton(type: .system)
          button.setImage(UIImage(named:"ribbon"), for: .normal)
          button.tintColor = UIColor(white: 0, alpha: 0.2)
          return button
      }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80 )
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
        configUserStatus()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 30)
        
            configButtonToolBar()
    }
    
    func configButtonToolBar(){
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    func  configUserStatus(){
        
        let stackView = UIStackView(arrangedSubviews: [postLabel,followersLabel,followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
