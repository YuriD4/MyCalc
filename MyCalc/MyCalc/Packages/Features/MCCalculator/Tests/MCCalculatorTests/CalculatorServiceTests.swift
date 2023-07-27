//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 25.07.2023.
//

import XCTest
import Combine
@testable import MCCalculator

class CalculatorOperationTypeTests: XCTestCase {
    func testCalculatorOperationTypeDescription() {
        XCTAssertEqual(CalculatorOperationType.add.description, "+")
        XCTAssertEqual(CalculatorOperationType.subtract.description, "-")
        XCTAssertEqual(CalculatorOperationType.multiply.description, "*")
        XCTAssertEqual(CalculatorOperationType.divide.description, "/")
        XCTAssertEqual(CalculatorOperationType.sin.description, "sin")
        XCTAssertEqual(CalculatorOperationType.cos.description, "cos")
    }
}

class CalculatorServiceImplTests: XCTestCase {
    var calculatorService: CalculatorService!

    override func setUp() {
        super.setUp()
        calculatorService = CalculatorServiceImpl()
    }

    func testAddition() {
        let operation = CalculatorOperation(type: .add, operand1: 5, operand2: 3)

        let expectation = XCTestExpectation(description: "Perform addition")
        let cancellable = calculatorService.performOperation(operation)
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { result in
                XCTAssertEqual(result, "8") // Expected result of addition: 5 + 3 = 8
            })

        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }

    func testDivisionByZero() {
        let operation = CalculatorOperation(type: .divide, operand1: 10, operand2: 0)

        let expectation = XCTestExpectation(description: "Perform division by zero")
        let cancellable = calculatorService.performOperation(operation)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, .divideByZero)
                case .finished:
                    XCTFail("Should receive an error")
                }
                expectation.fulfill()
            }, receiveValue: { _ in })

        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
}

