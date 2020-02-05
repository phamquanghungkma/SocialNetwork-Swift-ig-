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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        view.addSubview(plusPhotoBtn)
        plusPhotoBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    

   
    

}
