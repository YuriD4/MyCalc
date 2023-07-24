//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Combine

public enum CalculatorOperationType {
    case add
    case subtract
    case multiply
    case divide
    case sin
    case cos
}

public struct CalculatorOperation {
    let type: CalculatorOperationType
    let operand1: Double
    let operand2: Double?
}

public enum CalculatorError: Error {
    case divideByZero
    case unknown
}

public protocol CalculatorService {
    func performOperation(_ operation: CalculatorOperation) -> AnyPublisher<Double, CalculatorError>
}

public class CalculatorServiceImpl: CalculatorService {
    public init() { }
    
    public func performOperation(_ operation: CalculatorOperation) -> AnyPublisher<Double, CalculatorError> {
        return Future<Double, CalculatorError> { promise in
            let operand1 = operation.operand1
            
            switch operation.type {
            case .add:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(operand1 + operand2))
            case .subtract:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(operand1 - operand2))
            case .multiply:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                promise(.success(operand1 * operand2))
            case .divide:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                if operand2 == 0 {
                    promise(.failure(.divideByZero))
                } else {
                    promise(.success(operand1 / operand2))
                }
            case .sin:
                promise(.success(sin(operand1)))
            case .cos:
                promise(.success(cos(operand1)))
            }
        }
        .eraseToAnyPublisher()
    }
}
