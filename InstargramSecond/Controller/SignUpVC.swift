//
//  SignUp.swift
//  InstargramSecond
//
//  Created by Apple on 2/5/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var imageSelected = false

    let plusPhotoBtn : UIButton={
       let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelecProfilePhoto), for: .touchUpInside)
        
        return button
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
        button.isEnabled = false
        button.addTarget(self, action:#selector(handleSignUp), for: .touchUpInside)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // select image
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
            
        }
        
        // set imageSelected = true
        imageSelected = true
        
        // configure plusPhotoBtn with selected image
        
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        plusPhotoBtn.layer.borderWidth = 2
        plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleSelecProfilePhoto(){
        // configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // present image picker
        self.present(imagePicker,animated: true,completion: nil)
        
        
    }
    
    @objc func handleShowLogin(){
//        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text else { return }
        guard let password  = passwordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password){
            (user,error) in
                // handle error
            if let error = error {
                print("Failed to create user with error:",error.localizedDescription)
                return
            }
            //set profile image
            guard let profileImg = self.plusPhotoBtn.imageView?.image else{return}
            // upload data
            guard let  uploadData = profileImg.jpegData(compressionQuality: 0.3)
                else {return}
            
            // place image in firebase storage
            let filename = NSUUID().uuidString
                Storage.storage().reference().child("profile_images").child(filename)
                .putData(uploadData, metadata: nil,completion: {
                (metadata,error) in
                // handle Error
                if let error = error {
                    print("Failed to upload image to Firebase Storage with error",error.localizedDescription)
                }
                    
                // profile image url
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
//                  let profileImageURL =  metadata?.storageReference?.downloadURL(completion: { (url, error) in
//                        if let error = error {
//                            print(error.localizedDescription)
//                            return
//                        }
////                        SYS_access("\(url!)")
//                    })
                    
                    // user id
                    
                    let uid = user?.uid
                    
                    let dictionaryValues = ["names":fullname,
                                            "username":username,
                                            "email":email,
                                            "password":password,
                                            "profileImageURL": profileImageUrl as Any] as [String : Any]
                    
                    let values = [uid:dictionaryValues]
                    // save user infor to database
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock:{
                        (error,ref) in print(" Succesfully created user and saved information to database")
                    })
                })
            
            
            // success
            print("Succesfully created user with Firebase")
            self.navigationController?.popViewController(animated: true)

            
        }
    }
    @objc func formValidation(){
        // this function sets validation for emailInput and passInput
        //users must enter both 2 this field, then buttonSignUp change color and iseEnable = true
        guard emailTextField.hasText,
            passwordTextField.hasText,
            fullNameTextField.hasText,
            usernameTextField.hasText,
            imageSelected == true
        else {
                signUpButton.isEnabled = false
                signUpButton.backgroundColor =  UIColor(red:194/255,green:204/255,blue:244/255,alpha:1)
        
                return
        }
        signUpButton.isEnabled = true
        signUpButton.backgroundColor =  UIColor(red:17/255,green:154/255,blue:237/255,alpha:1)
        
        
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
