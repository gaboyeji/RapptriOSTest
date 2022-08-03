//
//  LoginClient.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/28/22.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123 
 *
*/

class LoginClient {
    
    var session: URLSession?
    
    func login(email: String, password: String, completion: @escaping (String, String, Bool) -> Void, error errorHandler: @escaping (String?) -> Void) {
        let timestamp_start = CFAbsoluteTimeGetCurrent()
        NetworkActivityIndicator().start()
        
        let url_endpoint = DOMAIN + LOGIN_URL
        guard let url = URL(string: url_endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        request.httpBody = parameters.noneAlphaNumEncoded()

        self.session = URLSession.shared
        let task = self.session!.dataTask(with: request) { data, response, error in
            
            // Uncomment for in-console server response
            //guard let _response = response else { return }
            //ConsoleLogger.debug("httpResponse: \(_response)")
            
            guard let data = data else { return }
            
            do {
                NetworkActivityIndicator().stop()
                
                // Calculating response duration in milli-seconds
                let timestamp_end = CFAbsoluteTimeGetCurrent() - timestamp_start
                let milli_secs = timestamp_end * 1000
                let res_duration = String(format: "%.0f", milli_secs)
                
                // Json to model object
                let loginRes = try JSONDecoder().decode(LoginRes.self, from: data)
                
                // In-console response message
                ConsoleLogger.debug("loginRes.message: \(loginRes.message)")
                let message = loginRes.message

                
                // In-console response duration
                ConsoleLogger.debug("response duration: \(res_duration) ms")
                
                if message.lowercased() == "Login Successful!".lowercased() {
                    completion(message, res_duration, true)
                } else {
                    completion(message, res_duration, false)
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
