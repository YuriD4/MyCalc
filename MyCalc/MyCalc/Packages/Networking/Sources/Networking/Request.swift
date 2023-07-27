//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Environment

public protocol APIRequest {
    associatedtype Response: Decodable
    
    var environment: APPEnvironment { get }
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
}
