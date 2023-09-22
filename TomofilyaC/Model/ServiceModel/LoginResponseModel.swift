//
//  LoginResponseModel.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 21.09.2023.
//

import Foundation

struct LoginResponseModel: Decodable {
    let success: Bool?
    let message: String?
}
