//
//  PasswordResetResponse.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 22.09.2023.
//

import Foundation

struct PasswordResetResponse : Decodable {
    let success : Bool?
    let message : String?
}
