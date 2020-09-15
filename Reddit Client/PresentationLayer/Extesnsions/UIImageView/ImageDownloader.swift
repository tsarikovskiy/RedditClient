//
//  ImageDownloader.swift
//  Reddit Client
//
//  Created by Anna on 15.09.2020.
//  Copyright © 2020 Serg Tsarikovskiy. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func load(url: URL, completion: ((Bool) -> Void)? = nil) {
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "placeholder-reddit")
                        completion?(false)
                    }
                    return
            }
            
            imageCache.setObject(image, forKey: url as AnyObject)
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
            
        }.resume()
    }
}
