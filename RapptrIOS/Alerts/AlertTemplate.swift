//
//  AlertTemplate.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 8/1/22.
//

import Foundation
import UIKit

public class AlertControllerTemplate: UIAlertController {
    
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ClearViewControllerTemplate()
        window.backgroundColor = UIColor.clear
        return window
    }()
    
    /**
     Present the AlertControllerTemplate on top of the visible UIViewController.

     - parameter flag:       Pass true to animate the presentation; otherwise, pass false. The presentation is animated by default.
     - parameter completion: The closure to execute after the presentation finishes.
     */
    public func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            rootViewController.present(self, animated: flag, completion: completion)
        }
    }
    
    deinit {
        alertWindow.isHidden = true
    }
    
}

private class ClearViewControllerTemplate: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle
    }
    
    var statusBarIsNotVisible = false
    override var prefersStatusBarHidden: Bool {
        if statusBarIsNotVisible == false {
            return false
        } else {
            return true
        }
    }
    
}
