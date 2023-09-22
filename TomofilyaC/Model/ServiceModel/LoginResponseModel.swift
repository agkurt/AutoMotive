//
//  LoginResponseModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.09.2023.
//

import Foundation

struct LoginResponseModel: Decodable {
    let data : loginData?
    let success: Bool?
    let message: String?
}

struct loginData : Decodable {
    let accessToken : String
    let refreshToken : String
    let fullName : String
    let userId : Int
    let expiration : String
    let isSocialMediaAccount : Bool
}
