//
//  Templates.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import UIKit

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK: UIVIEW-TEMPLATE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ViewTemplate: UIView {

    override init(frame: CGRect) { super.init(frame: frame); setupViews(); }
    //default for setup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented -->>")
    }
    
    func setupViews(){}
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK: UICollectionViewCell-TEMPLATE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CellCollectionTemplate: UICollectionViewCell {
    
    override init(frame: CGRect) { super.init(frame: frame); setupViews() }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setupViews(){}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK: UICollectionViewCell-TEMPLATE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CellTableTemplate: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setupViews() {}
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK: UIVIEW-CONTROLLER-TEMPLATE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ViewControllerTemplate: UIViewController {
    
    //MARK: StatusBar Color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var navTitle: String = ""
    var backgroundImageName: String = ""
    
    let bgImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: ui_background)
        self.navigationController?.navigationBar.isHidden = false
        self.title = self.navTitle
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(hex: ui_nav_header)
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(hex: fc_nav_header),
                .font: font_nav_header
            ]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hex: 0xffffff)]
            self.navigationController?.navigationBar.barTintColor = UIColor(hex: ui_nav_header)
        }

        
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARK: UIBUTTON-TEMPLATE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class BtnTemplate: UIButton {
    override init(frame: CGRect) { super.init(frame: frame); }
    //default for setup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented -->>")
    }
    
    func configure(c: ButtonLabel, align: ContentHorizontalAlignment = .left) {
        self.setTitle(c.title, for: .normal)
        self.setTitle(c.title, for: .highlighted)
        if c.isDefault {
            self.backgroundColor = UIColor(hex: c.color_bg).withAlphaComponent(0.8)
            self.layer.masksToBounds = c.masksToBounds
            self.layer.cornerRadius = c.cornerRadius
            self.contentHorizontalAlignment = align
            self.setTitleColor(UIColor(hex: c.color_text), for: .normal)
            self.setTitleColor(UIColor(hex: c.color_text), for: .highlighted)
            self.setImage(UIImage(named: c.icon), for: .normal)
            
            let sz: CGFloat = c.icon_size
            let diff: CGFloat = (self.frame.height - sz) / 2
            let ie: UIEdgeInsets = UIEdgeInsets(top: diff, left: c.padding_left, bottom: diff, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: diff, left: c.padding_left, bottom: diff, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: ie.left+16, bottom: 0, right: 0)
            self.titleLabel?.font = font_button
        } else {
            
            self.backgroundColor = UIColor(hex: c.color_bg)
            self.layer.masksToBounds = c.masksToBounds
            self.layer.cornerRadius = c.cornerRadius
            self.contentHorizontalAlignment = align
            self.setTitleColor(UIColor(hex: c.color_text), for: .normal)
            self.setTitleColor(UIColor(hex: c.color_text), for: .highlighted)
            self.setImage(nil, for: .normal)
            self.titleLabel?.font = font_button
        }

    }
}




