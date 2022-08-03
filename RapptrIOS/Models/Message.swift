//
//  Message.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import Foundation

struct Messages: Codable {
    var data: [Message]
}

// MARK: Message model refactored to as a sub-class of Codable
// for ease of parsing json
// Original Message Model below 
struct Message: Codable {
    let user_id: String // Renamed and type changed
    let name: String // Renamed and type changed
    let avatar_url: String // Renamed and type changed
    let message: String // Renamed and type changed
    
    init(
        // Updated DI to accept "user_id" and "avatar_url" parameter
        // and set with default value
        user_id: String = "0",
        author_name: String,
        withMessage message: String,
        avatar_url: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png"
    ) {
        self.user_id = user_id
        self.name = author_name
        self.avatar_url = avatar_url
        self.message = message
    }
}



// MARK: Original Message Model
struct MessageOriginal {
    var userID: Int
    var username: String
    var avatarURL: URL?
    var text: String
    
    init(testName: String, withTestMessage message: String) {
        self.userID = 0
        self.username = testName
        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
        self.text = message
    }
}


