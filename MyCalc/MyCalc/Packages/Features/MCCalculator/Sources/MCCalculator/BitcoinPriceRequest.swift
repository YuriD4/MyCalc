//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Networking
import Environment

public struct BitcoinPriceRequest: APIRequest {
    public typealias Response = BitcoinPriceResponse

    public var environment: APPEnvironment
    public var path: String { "/api/v3/ticker/price" }
    public var method: HttpMethod { .get }
    public var headers: [String: String] { [:] }
    public var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "symbol", value: "BTCUSDT")]
    }
    
    public var baseURL: URL {
        switch environment {
        case .dev:
            return URL(string: "https://api-dev.binance.com")!
        case .prod:
            return URL(string: "https://api.binance.com")!
        }
    }
}

public struct BitcoinPriceResponse: Decodable {
    public let symbol: String
    public let price: String
}
