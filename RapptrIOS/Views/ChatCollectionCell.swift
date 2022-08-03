//
//  ChatCollectionCell.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/29/22.
//

import UIKit

// MARK: Run project without Podfile
// Comment out: SDWebImage
import SDWebImage

class ChatCollectionCell: CellCollectionTemplate {
    
    static let cellIdentifier: String = "ChatCollectionCell"
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let userImageView: ImageFetcherView = {
        let v = ImageFetcherView()
        v.backgroundColor = UIColor(hex: 0xDDDDDD)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 25
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    lazy var usernameView: UILabel = {
        let v = UILabel()
        v.font = font_chat_usrnm
        v.textColor = UIColor(hex: fc_chat_usrnm)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let messageView: PaddedUILabel = {
        let v = PaddedUILabel()
        v.backgroundColor = .white
        v.textColor = UIColor(hex: fc_chat_msg)
        v.font = font_chat_msg
        v.layer.masksToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(hex: 0xEFEFEF).cgColor
        v.layer.cornerRadius = 8
        v.numberOfLines = 0
        v.paddingLeft = 8
        v.paddingRight = 8
        v.paddingTop = 8
        v.paddingBottom = 8
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .left
        v.textAlignment = .natural
        v.lineBreakMode = .byTruncatingTail
        v.baselineAdjustment = .alignBaselines
        return v
    }()
    
    override func setupViews() {
        
        container.addSubview(userImageView)
        container.addSubview(usernameView)
        container.addSubview(messageView)
        
        // Ref: visual
        //container.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        addSubview(container)

        //Constraints for content container
        setConstraintsWithFormat("H:|-16-[v0]-36-|", toView: container)
        setConstraintsWithFormat("V:|[v0]|", toView: container)
        
        //Constraints for userImageView
        container.setConstraintsWithFormat("H:|[v0(50)]", toView: userImageView)
        container.setConstraintsWithFormat("V:|[v0(50)]", toView: userImageView)
        
        //Constraints for usernameView
        container.setConstraintsWithFormat("H:[v0]-10-[v1]|", toView: userImageView, usernameView)
        container.setConstraintsWithFormat("V:|[v0(13)]", toView: usernameView)
        
        //Constraints for messageView
        container.setConstraintsWithFormat("H:[v0]-7-[v1]|", toView: userImageView, messageView)
        container.setConstraintsWithFormat("V:[v0]-4-[v1]|", toView: usernameView, messageView)
        
    }
    
    override func prepareForReuse() {
        self.userImageView.image = nil
    }
    
    // Configure mvm
    func configure(vm: MessageViewModel) {
        self.messageView.text = vm.message
        self.usernameView.text = vm.name
        
        // MARK: Run project without Podfile
        // Uncomment line 104
        // and comment line 106
        //self.userImageView.getImage(image_url: vm.avatar_url)
        
        self.userImageView.sd_setImage(with: URL(string: vm.avatar_url))
    }
}





