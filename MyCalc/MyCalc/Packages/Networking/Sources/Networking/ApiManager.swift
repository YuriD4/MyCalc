//
//  File 2.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Combine

public protocol APIManager {
    func send<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, ApiError>
}

public class APIManagerImpl: APIManager {
    private let defaultHeaders: [String: String] = ["Content-Type": "application/json"]

    public init() {
        
    }
    
    public func send<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, ApiError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.baseURL.scheme
        urlComponents.host = request.baseURL.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url else {
            return Fail(error: ApiError.customError("Invalid URL")).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = defaultHeaders.merging(request.headers) { (current, _) in current }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
               .map { $0.data }
               .decode(type: T.Response.self, decoder: JSONDecoder())
               .mapError { error in
                   if let error = error as? URLError, error.code == .notConnectedToInternet {
                       return ApiError.noInternetConnection
                   }
                   return ApiError.customError(error.localizedDescription)
               }
               .eraseToAnyPublisher()
    }
}
