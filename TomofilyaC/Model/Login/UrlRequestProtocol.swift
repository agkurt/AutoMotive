//
//  UrlRequestProtocol.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 19.09.2023.
//

import Foundation

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol URLRequestProtocol { // get isteği sadece okunabilir olduğunu gösterir.
    var url : URL { get }
    var body :   Data? { get }
    var method : HTTPMethod { get }
    var headers : [String : String]? { get }
    var urlRequest : URLRequest { get }
}

extension URLRequestProtocol {
    var urlRequest : URLRequest {
        var request = URLRequest(url : url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = body
        }
        headers?.forEach {(key , value ) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
        
}

