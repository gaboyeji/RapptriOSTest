//
//  NetworkActivityIndicator.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 8/1/22.
//

import UIKit

class NetworkActivityIndicator: NSObject {
    
    func start() {
        DispatchQueue.main.async(execute: { () -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
    }
    
    func stop() {
        DispatchQueue.main.async(execute: { () -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
}
