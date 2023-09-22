//
//  SocialResponseModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.09.2023.
//

import Foundation

struct SocialResponseModel : Decodable {
    let data : User?
    let success : Bool?
    let message : String?
}

struct User : Decodable {
    let accessToken : String
    let refreshToken : String
    let fullName : String
    let userID : Int
    let expiration : String
    let isSocialMediaAccount : Bool
}
