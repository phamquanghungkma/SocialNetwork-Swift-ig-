//
//  Extensions.swift
//  InstargramSecond
//
//  Created by Apple on 2/3/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit

extension UIView{
    // this is a function
    func anchor(
        top:NSLayoutYAxisAnchor?,
        left:NSLayoutXAxisAnchor?,
        bottom:NSLayoutYAxisAnchor?,
        right:NSLayoutXAxisAnchor?,
        paddingTop:CGFloat,// gia tri
        paddingLeft:CGFloat,// gia tri
        paddingBottom:CGFloat,// gia tri
        paddingRight:CGFloat,// gia tri
        width:CGFloat,
        height:CGFloat
        ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}
    var imageCache = [String: UIImage]() // initalize an empty dictionary

extension UIImageView{
    func loadImage(with urlString: String ){
        
        // check if image exist in cache ( check urlString if exist in Dictionary)
        if let cachedImage = imageCache[urlString]{
            self.image = cachedImage
            return
        }
        
        // url for image location
        guard let url = URL(string: urlString) else {return}
        //fetch content of URL
        URLSession.shared.dataTask(with: url) { (data,respone,error) in
            // handle error
            if let error = error { print("failed to load Image with error : \(error.localizedDescription)")}
            //image Data
            guard let imageData = data else { return }
            // set image using imageData
            let photoImage = UIImage(data: imageData)
            // set key and value for image cache
            imageCache[url.absoluteString] = photoImage
            // set image
            DispatchQueue.main.async{ self.image = photoImage}
        }.resume()
    }
}



