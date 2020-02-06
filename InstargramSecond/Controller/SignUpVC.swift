//
//  SignUp.swift
//  InstargramSecond
//
//  Created by Apple on 2/5/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    let plusPhotoBtn : UIButton={
       let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        return tf
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        return tf
    }()
    let fullNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        return tf
    }()
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        return tf
    }()
    let signUpButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Un", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red:194/255,green:204/255,blue:244/255,alpha:1)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type:.system)
        let attributedTitle =  NSMutableAttributedString(string: "Already have an account! ", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string:"Sign In", attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor(red:17/255,green:154/255,blue:237/255,alpha:1)]))
        
        
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        /* everytime this button is clicked, it's going to call handleShowSignUp() function*/
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        view.addSubview(plusPhotoBtn)
        plusPhotoBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureViewComponents()
        
    }
    
    @objc func handleShowLogin(){
//        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)

    
    }
    
    func configureViewComponents(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,fullNameTextField,usernameTextField,passwordTextField,signUpButton,alreadyHaveAccountButton])
        stackView.axis = .vertical // chieu của stack view la .vertical dùng cho UIStackView
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top:plusPhotoBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 40, paddingBottom: 1000, paddingRight: 40, width: 0, height: 300)
        
        
    }

   
    

}
