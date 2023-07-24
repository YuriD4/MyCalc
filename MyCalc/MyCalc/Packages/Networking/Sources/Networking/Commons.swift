//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation

public enum ApiError: Error {
    case noInternetConnection
    case customError(String)
    case unknown
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    // other methods as needed
}
