//
//  LoginVC.swift
//  InstargramSecond
//
//  Created by Apple on 2/3/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView  = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        
        // set image to center
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        
        return tf
    }() 
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let logginButton: UIButton = {
        
            let button = UIButton(type: .system)
                button.setTitle("Login", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor(red:194/255,green:204/255,blue:244/255,alpha:1)
                button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
                button.layer.cornerRadius = 5
                button.isEnabled = false
            return button
    }()
    
    let dontHaveAccountButton : UIButton = {
        let button = UIButton(type:.system)
        let attributedTitle =  NSMutableAttributedString(string: "Don't have an account! ", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string:"Sign Up", attributes:[NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor(red:17/255,green:154/255,blue:237/255,alpha:1)]))
        
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        /* everytime this button is clicked, it's going to call handleShowSignUp() function*/
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // backgroundColor
        view.backgroundColor = .white
        print("View did load ")
        
        // hide nav bar
        navigationController?.navigationBar.isHidden = true
        
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
      
        configureViewComponents()
        
        
       
    }
    @objc func handleShowSignUp(){
        /*
         Ham nay thuc hien nhiem vu dieu huong sang man hinh SignUP
         */
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin(){
        print("Handle login here")
        
        guard let email = emailTextField.text,
           let password = passwordTextField.text else {return}
        // sign in with email and password
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            // handle error
            if let error = error {
                print("Unable to sign user in error",error.localizedDescription)
                return
            }
            // handle success
            print("Successly Sign user in")
            
            guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else {return}
            
            // configure view controllers in maintabvc
            mainTabVC.configureViewControllers()
            
            //dismiss login controller
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func formValidation(){
        guard
            emailTextField.hasText,
            passwordTextField.hasText
            else {
//                handle case for above conditions not met
                logginButton.isEnabled  = false
                logginButton.backgroundColor = UIColor(red:194/255,green:204/255,blue:244/255,alpha:1)
                return
        }
//       handle case for above conditions were met
        logginButton.isEnabled = true
        logginButton.backgroundColor = UIColor(red:17/255,green:154/255,blue:237/255,alpha:1)
        
        
    }
    
    
    
    func configureViewComponents(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,logginButton,dontHaveAccountButton])
        stackView.axis = .vertical // chieu của stack view la .vertical dùng cho UIStackView
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top:logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 1000, paddingRight: 40, width: 0, height: 200)
        
        
    }
    

   

}
