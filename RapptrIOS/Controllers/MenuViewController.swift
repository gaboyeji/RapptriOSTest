//
//  MenuViewController.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import UIKit

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 *
 * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
 *
 * 2) Use Autolayout to make sure all UI works for each resolution
 *
 * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
 *    provided code if necessary. It is ok to add any classes. This is your project now!
 *
 * 4) Read the additional instructions comments throughout the codebase, they will guide you.
 *
 * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
 *
 * Thank you and Good luck. - Rapptr Labs
 * =========================================================================================
 */

class MenuViewController: ViewControllerTemplate {
    
    // MARK: StatusBar Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: BTN-CHAT
    lazy var btnChat: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Chat",
            color_text: fc_button_text,
            color_bg: 0xffffff,
            icon: "ic_chat",
            masksToBounds: true,
            cornerRadius: 8.0
        )
        v.configure(c: c, align: .left)
        v.addTarget(self, action: #selector(self.didTapChatBtn), for: .touchUpInside)
        return v
    }()
    
    // MARK: BTN-LOGIN
    lazy var btnLogin: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Login",
            color_text: fc_button_text,
            color_bg: 0xffffff,
            icon: "ic_login",
            masksToBounds: true,
            cornerRadius: 8.0
        )
        v.configure(c: c, align: .left)
        v.addTarget(self, action: #selector(self.didTapLoginBtn), for: .touchUpInside)
        return v
    }()
    
    // MARK: BTN-ANIMATION
    lazy var btnAnimation: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Animation",
            color_text: fc_button_text,
            color_bg: 0xffffff,
            icon: "ic_animation",
            masksToBounds: true,
            cornerRadius: 8.0
        )
        v.configure(c: c, align: .left)
        v.addTarget(self, action: #selector(self.didTapAnimationBtn), for: .touchUpInside)
        return v
    }()
    
    let containerView: UIView = { let v = UIView(); return v }()
    
    @objc
    func didTapChatBtn() {
        ConsoleLogger.debug("Chat button TAPPED!")
        let vc = ChatViewController()
        vc.navTitle = "Chat"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func didTapLoginBtn() {
        ConsoleLogger.debug("Login button TAPPED!")
        let vc = LoginViewController()
        vc.navTitle = "Login"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func didTapAnimationBtn() {
        ConsoleLogger.debug("Animation button TAPPED!")
        let vc = AnimationViewController()
        vc.navTitle = "Animation"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "Coding Tasks"
        self.title = self.navTitle

        backgroundImageName = "bg_home_menu"
        bgImageView.image = UIImage(named: backgroundImageName)
        view.addSubview(bgImageView)
        view.addSubview(containerView)
        containerView.addSubview(btnChat)
        containerView.addSubview(btnLogin)
        containerView.addSubview(btnAnimation)
        
        // Constraints for Background Image
        view.setConstraintsWithFormat("H:|[v0]|", toView: bgImageView)
        view.setConstraintsWithFormat("V:|[v0]|", toView: bgImageView)
        
        let ch: CGFloat = (BUTTON_HEIGHT*3)+(24*2)
        let vh: CGFloat = (SCREEN_SIZE.height-(ch))/2
        view.setConstraintsWithFormat("H:|-30-[v0]-30-|", toView: containerView)
        view.setConstraintsWithFormat("V:|-\(vh)-[v0(\(ch))]-\(vh)-|", toView: containerView)
        
        // Constraints for Chat button
        containerView.setConstraintsWithFormat("H:|[v0]|", toView: btnChat)
        containerView.setConstraintsWithFormat("V:[v0(\(BUTTON_HEIGHT))]", toView: btnChat)

        // Constraints for Login button
        containerView.setConstraintsWithFormat("H:|[v0]|", toView: btnLogin)
        containerView.setConstraintsWithFormat("V:[v0]-24-[v1(\(BUTTON_HEIGHT))]", toView: btnChat, btnLogin)

        // Constraints for Animation button
        containerView.setConstraintsWithFormat("H:|[v0]|", toView: btnAnimation)
        containerView.setConstraintsWithFormat("V:[v0]-24-[v1(\(BUTTON_HEIGHT))]", toView: btnLogin, btnAnimation)
        
        
        ConsoleLogger.debug("loaded!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Coding Tasks"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
}

