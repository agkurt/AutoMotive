//
//  APIManager.swift
//  TomofilyaC
//
//  Created by Ahmet Göktürk Kurt on 17.08.2023.
//

import Foundation

struct Network {
    
    static func send<T: Decodable>(request: URLRequestProtocol , completion: @escaping(Result<T , Error>) -> Void) {
        URLSession.shared.dataTask(with: request.urlRequest) { (data , response , error) in
            if let error = error { // unwrap
                completion(.failure(error))
                return
            }
            guard let data = data else  {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }
        }
        .resume()
    }
    
    enum NetworkError: Error {
        case emptyResponse
    }
}
