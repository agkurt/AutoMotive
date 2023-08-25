//
//  AuthService.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 17.08.2023.
//

import UIKit

class AuthService {
    static let shared = AuthService()
    
    func register(userDetails: [String: Any], completion: @escaping (Bool, String?) -> Void) {
        if let url = APIManager.shared.getURL(for: .register) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()
            request.httpBody = try? JSONSerialization.data(withJSONObject: userDetails)
            
            performRequest(request: request, completion: completion)
        } else {
            completion(false, "Failed to create URL.")
        }
    }
    
    func verify(email: String, code: String, completion: @escaping (Bool, String?) -> Void) {
        if let url = APIManager.shared.getURL(for: .verifyCode) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()
            let bodyData = [
                "email": email,
                "code": code
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData)
            
            performRequest(request: request, completion: completion)
        } else {
            completion(false, "Failed to create URL.")
        }
    }

    
    func login(credentials: [String: Any], completion: @escaping (Bool, String?) -> Void) {
        if let url = APIManager.shared.getURL(for: .login) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()
            request.httpBody = try? JSONSerialization.data(withJSONObject: credentials)
            
            performRequest(request: request, completion: completion)
        } else {
            completion(false, "Failed to create URL.")
        }
    }
    
    func sendPasswordResetEmail(email: String, completion: @escaping (Bool, String?) -> Void) {
        if let url = APIManager.shared.getURL(for: .sendVerificationCode, email: email) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()
            
            performRequest(request: request, completion: completion)
        } else {
            completion(false, "Failed to create URL.")
        }
    }

    
    private func performRequest(request: URLRequest, completion: @escaping (Bool, String?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(false, err.localizedDescription)
                return
            }
            
          
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
          
            if let rawResponse = String(data: data!, encoding: .utf8) {
                print("Raw Response: \(rawResponse)")
            }
            
            guard let data = data else {
                completion(false, "No data was returned.")
                return
            }
            
            
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
               let success = jsonResponse["success"] as? Bool {
                if success {
                    if let token = jsonResponse["data"] as? String {
                        completion(true, token)
                    } else {
                        completion(true, nil)
                    }
                } else {
                    if let message = jsonResponse["message"] as? String {
                        completion(false, message)
                    } else {
                        completion(false, "An unknown error occurred.")
                    }
                }
            } else {
                completion(false, "Could not parse response.")
            }
        }
        task.resume()
    }
    func socialLogin(token: String, platform: SocialPlatform, completion: @escaping (Bool, String?, Bool) -> Void) {
        if let url = APIManager.shared.getURL(for: .socialLogin) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()

            let bodyData: [String: Any] = [
                "token": token,  // Burada "token" yerine "idToken" kullanıyoruz.
                "platform": platform.rawValue
            ]

            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData)
            
            performRequest(request: request) { (success, messageOrToken) in
                if success {
                    let isSocialMediaAccount = (platform == .Google || platform == .Apple)
                    completion(true, messageOrToken, isSocialMediaAccount)
                } else {
                    completion(false, messageOrToken, false)
                }
            }
        } else {
            completion(false, "Failed to create URL.", false)
        }
    }



    
    func resetPassword(email: String, code: String, newPassword: String, completion: @escaping (Bool, String?) -> Void) {
        if let url = APIManager.shared.getURL(for: .passwordReset) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = APIManager.shared.getDefaultHeaders()
            let bodyData = [
                "email": email,
                "code": code,
                "newPassword": newPassword
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData)
            
            performRequest(request: request, completion: completion)
        } else {
            completion(false, "Failed to create URL.")
        }
    }



}

