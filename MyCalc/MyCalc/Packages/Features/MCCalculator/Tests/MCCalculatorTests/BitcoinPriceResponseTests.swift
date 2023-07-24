//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 25.07.2023.
//


import XCTest
@testable import MCCalculator

class BitcoinPriceResponseTests: XCTestCase {
    func testBitcoinPriceResponseDecoding() {
        // Sample JSON data for the response
        let jsonData = """
            {
                "symbol": "BTCUSDT",
                "price": "50000"
            }
            """.data(using: .utf8)!

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(BitcoinPriceResponse.self, from: jsonData)

            XCTAssertEqual(response.symbol, "BTCUSDT")
            XCTAssertEqual(response.price, "50000")
        } catch {
            XCTFail("Failed to decode BitcoinPriceResponse with error: \(error)")
        }
    }
}
