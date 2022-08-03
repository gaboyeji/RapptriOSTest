//
//  AnimationViewController.swift
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
 * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
 *    section in Swfit to show off your skills. Anything your heart desires!
 *
 */

class AnimationViewController: ViewControllerTemplate {
    
    deinit {
        ConsoleLogger.debug("Cycle ended!")
    }
    
    let logoImageView: DraggableView = {
        let padding: CGFloat = PADDING_LEFT
        let w: CGFloat = (SCREEN_SIZE.width - (padding * 2))
        let y: CGFloat = ORIGIN_Y
        let v = DraggableView(frame: CGRect(x: padding, y: y, width: w, height: BUTTON_HEIGHT))
        v.image = UIImage(named: "ic_logo")
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    // MARK: BTN-FADDER
    lazy var btnFadeAction: BtnTemplate = {
        let v = BtnTemplate()
        let c = ButtonLabel(
            title: "Fade Out".uppercased(),
            color_text: 0xffffff,
            color_bg: ui_button,
            icon: "",
            masksToBounds: false,
            isDefault: false
        )
        v.configure(c: c, align: .center)
        v.addTarget(self, action: #selector(self.didTapFadeBtn), for: .touchUpInside)
        return v
    }()
    
    var isFadeOut: Bool = false
    
    @objc
    func didTapFadeBtn() {
        if !self.isFadeOut {
            self.isFadeOut = true
            ConsoleLogger.debug("fading out...")
            self.doAnimation(alpha: 0.0)
            self.btnFadeAction.setTitle("Fade In".uppercased(), for: .normal)
        } else {
            ConsoleLogger.debug("fading in...")
            self.isFadeOut = false
            self.doAnimation(alpha: 1.0)
            self.btnFadeAction.setTitle("Fade Out".uppercased(), for: .normal)
        }
    }
    
    //MARK: FADE IN/OUT
    func doAnimation(alpha: CGFloat) {
        UIView.animate(withDuration: 0.3
            , animations: {
            self.logoImageView.alpha = alpha
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.masksToBounds = true
        view.addSubview(btnFadeAction)
        view.addSubview(logoImageView)
        
        // Constraints for Fade button
        let pl = PADDING_LEFT
        let pr = PADDING_RIGHT
        let bm = PADDING_LEFT //bottom margin
        view.setConstraintsWithFormat("H:|-\(pl)-[v0]-\(pr)-|", toView: btnFadeAction)
        view.setConstraintsWithFormat("V:[v0(\(BUTTON_HEIGHT))]-\(bm)-|", toView: btnFadeAction)
        
        ConsoleLogger.debug("loaded!")
    }
}
