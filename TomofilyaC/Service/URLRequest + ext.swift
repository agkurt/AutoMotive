//
//  URLRequestProtocol.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 20.09.2023.
//

import Foundation

extension URLRequestProtocol {
    var URLRequest : URLRequest {
        var request = Foundation.URLRequest(url : url)
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
