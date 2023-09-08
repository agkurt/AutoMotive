//
//  APIManager.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 17.08.2023.
//

import UIKit

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://tomofilya.azurewebsites.net"
    private let apiKey = "COF40RZ95GBJZ7R08QVJMIDR0TLEJL1DDEXY10K0H8MQ03DJJ8"
    
    enum Endpoint: String {
        case register = "/user/post"
        case verifyCode = "/user/verifycode"
        case login = "/authentication/login"
        case socialLogin = "/authentication/social"
        case sendVerificationCode = "/user/sendverificationcode/{email}"
        case passwordReset = "/user/passwordreset"
        case homeAll = "/Home/All"
    }

    func getURL(for endpoint: Endpoint, email: String? = nil) -> URL? {
        switch endpoint {
        case .sendVerificationCode:
            guard let encodedEmail = email?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                return nil
            }
            return URL(string: baseURL + endpoint.rawValue.replacingOccurrences(of: "{email}", with: encodedEmail))
        default:
            return URL(string: baseURL + endpoint.rawValue)
        }
    }
    
    
    func getDefaultHeaders(withToken token: String? = nil) -> [String: String] {
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "ApiKey": apiKey
        ]
        
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
}

