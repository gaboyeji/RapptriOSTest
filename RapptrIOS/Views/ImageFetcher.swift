//
//  ImageFetcher.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/30/22.
//

import UIKit

let ImageCache = NSCache<AnyObject, AnyObject>()


class ImageFetcherView: UIImageView {
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func downloadImage(url: URL) {
        
        self.getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() { () -> Void in
                
                let imageToCache = UIImage(data: data)
                self.image = UIImage(data: data)
                
                // Cache image
                ImageCache.setObject(imageToCache!, forKey: url as AnyObject)
            }
        }
    }
    
    
    func getImage(image_url: String) {
        if let checkedUrl = URL(string: image_url) {
            
            if let imageFromCache = ImageCache.object(forKey: checkedUrl as AnyObject) {
                
                // Read from cached
                self.image = imageFromCache as? UIImage
                return
            }
            self.downloadImage(url: checkedUrl)
        }
    }
    
    
}
