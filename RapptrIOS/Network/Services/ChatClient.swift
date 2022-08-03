//
//  ChatClient.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    var session: URLSession?
    
    func fetchChatData(completion: @escaping ([MessageViewModel], String) -> Void, error errorHandler: @escaping (String?) -> Void) {
        let timestamp_start = CFAbsoluteTimeGetCurrent()
        NetworkActivityIndicator().start()
        
        let url_endpoint = DOMAIN + CHAT_URL
        let url = URL(string: url_endpoint) //else { return }

        self.session = URLSession.shared
        let task = session!.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                NetworkActivityIndicator().stop()
                // Calculating response duration in milli-seconds
                let timestamp_end = CFAbsoluteTimeGetCurrent() - timestamp_start
                let milli_secs = timestamp_end * 1000
                let res_duration = String(format: "%.0f", milli_secs)
                
                // Json to model object
                let allMessages = try JSONDecoder().decode(Messages.self, from: data)
                
                // Uncomment to show messages count in console
                ConsoleLogger.debug("messages received count: \(allMessages.data.count)")
                
                DispatchQueue.main.async {
                    
                    // Map Message object to MessageViewModel object
                    let mvm: [MessageViewModel] = allMessages.data.map({return MessageViewModel(message: $0)})
                    completion(mvm, res_duration)
                }
            } catch {
                NetworkActivityIndicator().stop()
                ConsoleLogger.debug("\n\nJSONDecoder ERROR!\n\n")
                errorHandler(error.localizedDescription)
            }
        }
        task.resume()
    }
}
