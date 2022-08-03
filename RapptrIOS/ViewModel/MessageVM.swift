//
//  MessageVM.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import Foundation

struct MessageViewModel {
    let user_id: String
    let name: String
    let avatar_url: String
    let message: String
    
    init(message: Message) {
        self.user_id = message.user_id
        self.name = message.name
        
        if message.avatar_url ==  "" {
            self.avatar_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png"
        } else {
            self.avatar_url = message.avatar_url
        }
        
        self.message = message.message
    }
}
