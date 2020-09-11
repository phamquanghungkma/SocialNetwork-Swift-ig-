//
//  CustomImageView.swift
//  InstargramSecond
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Tofu. All rights reserved.
//

import UIKit


var imageCache = [String: UIImage]() // initalize an empty dictionary
class CustomImageView: UIImageView{
    
    var lastImgUrlUsedToLoadImage: String?
    
    func loadImage(with urlString: String){
        
        //set image to nil
        self.image = nil // UIImageView.image = nil
        
        //set lastImgUrlUsedToLoadImage
        lastImgUrlUsedToLoadImage = urlString // đường link ảnh lấy đc từ DB
           
           // check if image exist in cache ( check urlString if exist in Dictionary)
           if let cachedImage = imageCache[urlString]{
               self.image = cachedImage
               return // thoat luon khoi cai ham nay
           }
           
           // url for image location
           guard let url = URL(string: urlString) else {return}
           //fetch content of URL
           URLSession.shared.dataTask(with: url) { (data,respone,error) in
               // handle error
               if let error = error { print("failed to load Image with error : \(error.localizedDescription)")}
            
            if self.lastImgUrlUsedToLoadImage != url.absoluteString {
                print("If Blocked excuted")
                return
            }
            
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
