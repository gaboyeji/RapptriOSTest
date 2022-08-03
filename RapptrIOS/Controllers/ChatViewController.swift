//
//  ChatViewController.swift
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
 * 2) Using the following endpoint, fetch chat data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 * 3) Parse the chat data using 'Message' model
 *
 **/

class ChatViewController: ViewControllerTemplate {
    deinit {
        ConsoleLogger.debug("Cycle ended!")
    }
    
    lazy var chats: ChatCollection = {
        let y: CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let h = (SCREEN_SIZE.height - y)
        let v = ChatCollection(frame: CGRect(x: 0, y: y, width: SCREEN_SIZE.width, height: h))
        v.messageCollection.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: y+50, right: 0)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chats)
        
        ConsoleLogger.debug("loaded!")
    }
    
}
