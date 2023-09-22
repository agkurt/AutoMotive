//
//  UserNetworkServiceRoute.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 20.09.2023.
//

import Foundation

enum UserNetworkServiceRoute : URLRequestProtocol {
    
    static let baseURL = "https://tomofilya.azurewebsites.net"
    
case register(fullName: String, email: String, password: String)
case verifyCode(email: String, code: String)
case login(email  :String , password : String)
case socialLogin(token: String, platform: String)
case sendVerificationCode(email: String)
case passwordReset(email: String, verificationCode: String, password: String)

    //create URL
    var url : URL {
        switch self {
        case .sendVerificationCode(let email):
            guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                fatalError("Geçersiz email")
            }
            return URL(string: UserNetworkServiceRoute.baseURL + path.replacingOccurrences(of: "{email}", with: encodedEmail))!
        default:
            return URL(string: UserNetworkServiceRoute.baseURL + path)!
        }
    }
    // create path
    var path: String {
        switch self {
        case .register:
            return "/user/post"
        case .verifyCode:
            return "/user/verifycode"
        case .login:
            return "/authentication/login"
        case .socialLogin:
            return "/authentication/social"
        case .sendVerificationCode:
            return "/user/sendverificationcode/{email}"
        case .passwordReset:
            return "/user/passwordreset"
        }
    }
    //create httpMethod
    var method : HTTPMethod {
        switch self {
        case .register , .verifyCode , .login , .socialLogin , .passwordReset:
            return .post
        case .sendVerificationCode:
            return .get
        }
    }
    // create body
    var body: Data? {
        switch self {
        case .register(let fullName , let email , let password):
            let parameters =  ["fullName" : fullName , "email": email , "password" : password]
            return try? JSONSerialization.data(withJSONObject: parameters , options: [])
            
        case .verifyCode(let email , let code) :
            let parameters = ["email" : email , "code" : code]
            return try? JSONSerialization.data(withJSONObject: parameters , options: [])
            
        case .login(let email , let password) :
            let parameters = ["email" : email , "password" : password]
            return try? JSONSerialization.data(withJSONObject: parameters, options: [])// try = nil döndürmek amacı
            
        case .socialLogin(let token , let platform) :
            let parameters = ["token" : token , "platform" : platform]
            return try? JSONSerialization.data(withJSONObject: parameters ,options: [])
            
        case .passwordReset(let email , let code , let password):
            return try? JSONSerialization.data(withJSONObject: ["email" : email , "code" : code , "password" : password] , options: [])
        default:
            return nil
        }
    }
    var headers: [String : String]? {
        var headers = [
            "Content-Type" :"application/json",
            "Api-Key" :"COF40RZ95GBJZ7R08QVJMIDR0TLEJL1DDEXY10K0H8MQ03DJJ8"
        ]
        switch self {
        case .socialLogin(let token , _) :
            headers["Authorization"] = "Bearer \(token)"
        default:
            break
        }
        return headers
    }
    
    
}

