import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
//        didSet will get called immediately when the user property is already se
        didSet {
            //config editProfileButton
            configuredEditProfileFollowButton()
// as soon as user is set value, didSet get called, create fullName having value = user.name and set nameLabel = fullName
            
            let fullName = user?.name
            nameLabel.text = fullName
            
            guard let profileImageUrl = user?.profileImage else {return}
            profileImageView.loadImage(with:profileImageUrl)
        }
    }
    
    let  profileImageView : UIImageView  = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
        
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
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
    
    let editProfileFollowButton : UIButton = {
        let button  = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
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
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 0, height: 30)
        
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
    
    func configuredEditProfileFollowButton(){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        guard let user = self.user else {return}
        
        if currentUid == user.uid {
            // config button as edit profile
            editProfileFollowButton.setTitle("Edit Profile", for: .normal)
        }
        else {
            // config button as follow button
            editProfileFollowButton.setTitle("Follow", for: .normal)
            editProfileFollowButton.setTitleColor(.white, for: .normal)
            editProfileFollowButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
