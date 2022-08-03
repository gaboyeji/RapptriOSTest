//
//  LoginViewController.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/29/22.
//

import UIKit

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Take email and password input from the user
 *
 * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
 *
 * 4) Calculate how long the API call took in milliseconds
 *
 * 5) If the response is an error display the error in a UIAlertController
 *
 * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
 *
 * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
 **/

class LoginViewController: ViewControllerTemplate {
    
    deinit {
        ConsoleLogger.debug("Cycle ended!")
    }

    lazy var grTap: UITapGestureRecognizer = {
        let v = UITapGestureRecognizer()
        v.numberOfTouchesRequired = 1
        v.numberOfTapsRequired = 1
        v.addTarget(self, action: #selector(self.dismissKeyboard))
        return v
    }()
    
    // MARK: TapGestureView
    let tapGestureView: UIView = {
        let v = UIView()//(frame: SCREEN_SIZE)
        return v
    }()
    
    
    // MARK: TF-EMAIL
    lazy var tfEmail: TextFieldTemplate = {
        let v = TextFieldTemplate()
        v.padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        v.backgroundColor = .white
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 6
        v.text = ""
        v.font = font_login_filled
        v.textColor = UIColor(hex: fc_login_filled)
        v.textAlignment = .left
        v.attributedPlaceholder = NSAttributedString(
            string: placeholder_email,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(hex: fc_login_placeholder),
                NSAttributedString.Key.font: font_login_placeholder
            ]
        )
        return v
    }()
    
    // MARK: TF-PASSWORD
    lazy var tfPassword: TextFieldTemplate = {
        let v = TextFieldTemplate()
        v.padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        v.backgroundColor = .white
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 6
        v.text = ""
        v.font = font_login_filled
        v.textColor = UIColor(hex: fc_login_filled)
        v.textAlignment = .left
        v.isSecureTextEntry = true
        v.attributedPlaceholder = NSAttributedString(
            string: placeholder_password,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(hex: fc_login_placeholder),
                NSAttributedString.Key.font: font_login_placeholder
            ]
        )
        return v
    }()
    
    //MARK: BTN_LOGIN - CornerRaduis to match textfield look
    lazy var btnLogin: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Login".uppercased(),
            color_text: 0xffffff,
            color_bg: ui_button,
            icon: "",
            masksToBounds: true,
            cornerRadius: 8.0,
            isDefault: false
        )
        v.configure(c: c, align: .center)
        v.addTarget(self, action: #selector(self.didTapLoginBtn), for: .touchUpInside)
        return v
    }()
    
    //MARK: BTN-FILL INPUT
    lazy var btnFillInput: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Fill Input".uppercased(),
            color_text: 0xffffff,
            color_bg: 0xff6505,
            icon: "",
            masksToBounds: true,
            cornerRadius: 8.0,
            isDefault: false
        )
        v.configure(c: c, align: .center)
        v.addTarget(self, action: #selector(self.didTapFillInput), for: .touchUpInside)
        return v
    }()
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func didTapFillInput() {
        self.tfEmail.text = test_email
        self.tfPassword.text = test_password
    }
    
    @objc
    func didTapLoginBtn() {
        
        self.btnLogin.isEnabled = false
        
        let email = self.tfEmail.text!
        let password = self.tfPassword.text!
        
        if email == "" && password == "" {
            DispatchQueue.main.async {
                let alert = AlertControllerTemplate(
                    title: "Login Error!",
                    message: "Email or Password is empty",
                    preferredStyle: .alert
                )
                
                alert.addAction(
                    UIAlertAction(
                        title: "Try again",
                        style: .default,
                        handler: { _ in
                            self.btnLogin.isEnabled = true
                        }))
                alert.show()
            }
            return
        }
        
        self.dismissKeyboard()
        
        let loginCLient = LoginClient()
        loginCLient.login(email: email, password: password) { message, res_duration, successful in
            let alert_message = "\(message), duration: \(res_duration)(ms)"
            
            DispatchQueue.main.async {
                
                var alert_title = "Login Successful!"
                if !successful { alert_title = "Login Failed!" }
                
                let alert = AlertControllerTemplate(
                    title: alert_title,
                    message: alert_message,
                    preferredStyle: .alert
                )
                if successful {
                    alert.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: { action in
                                self.navigationController?.popToRootViewController(animated: true)
                    }))
                } else {
                    alert.addAction(
                        UIAlertAction(
                            title: "Try again",
                            style: .default,
                            handler: { _ in
                                self.btnLogin.isEnabled = true
                            }))
                }
                
                alert.show()
            }
        } error: { error in
            let alert_error_message = "\(error!)"
            DispatchQueue.main.async {
                let alert = AlertControllerTemplate(
                    title: "Login Error",
                    message: alert_error_message,
                    preferredStyle: .alert
                )
                // Try again
                alert.addAction(
                    UIAlertAction(
                        title: "Try again",
                        style: .default,
                        handler: { _ in
                            self.btnLogin.isEnabled = true
                }))
                
                // Cancel
                alert.addAction(
                    UIAlertAction(
                        title: "Cancel",
                        style: .cancel,
                        handler: { action in
                            self.navigationController?.popToRootViewController(animated: true)
                }))
                alert.show()
            }
        }
        
        ConsoleLogger.debug("tapped Login btn")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureView.addGestureRecognizer(grTap)
        backgroundImageName = "img_login"
        bgImageView.image = UIImage(named: backgroundImageName)
        view.addSubview(tapGestureView)
        view.addSubview(bgImageView)
        view.addSubview(tfEmail)
        view.addSubview(tfPassword)
        view.addSubview(btnLogin)
        view.addSubview(btnFillInput)
        
        // Constraints for Background Image
        view.setConstraintsWithFormat("H:|[v0]|", toView: bgImageView)
        view.setConstraintsWithFormat("V:|[v0]|", toView: bgImageView)
        
        // Constraints for Gesture view
        view.setConstraintsWithFormat("H:|[v0]|", toView: tapGestureView)
        view.setConstraintsWithFormat("V:|[v0]|", toView: tapGestureView)
        
        // Constraints for Email text-field
        let navBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + 64
        let pl = PADDING_LEFT
        let pr = PADDING_RIGHT
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: tfEmail)
        view.setConstraintsWithFormat("V:|-\(navBarHeight)-[v0(\(INPUT_LABEL_HEIGHT))]", toView: tfEmail)
        
        
        // Constraints for Password text-field
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: tfPassword)
        view.setConstraintsWithFormat("V:[v0]-\(VERTICAL_MARGIN)-[v1(\(INPUT_LABEL_HEIGHT))]", toView: tfEmail, tfPassword)
        
        // Constraints for Login text-field
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: tfPassword)
        view.setConstraintsWithFormat("V:[v0]-\(VERTICAL_MARGIN)-[v1(\(INPUT_LABEL_HEIGHT))]", toView: tfEmail, tfPassword)
        
        // Constraints for Login button
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: btnLogin)
        view.setConstraintsWithFormat("V:[v0]-\(VERTICAL_MARGIN)-[v1(\(BUTTON_HEIGHT))]", toView: tfPassword, btnLogin)
        
        // Constraints for Fill Input button
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: btnFillInput)
        view.setConstraintsWithFormat("V:[v0(\(BUTTON_HEIGHT))]-\(VERTICAL_MARGIN)-|", toView: btnFillInput)
        
        ConsoleLogger.debug("loaded!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismissKeyboard()
    }
}



