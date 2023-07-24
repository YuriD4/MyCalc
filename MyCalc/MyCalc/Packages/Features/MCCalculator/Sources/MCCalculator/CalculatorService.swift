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
    
    var description: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .sin: return "sin"
        case .cos: return "cos"
        }
    }
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
    func performOperation(_ operation: CalculatorOperation) -> AnyPublisher<String, CalculatorError>
}

public class CalculatorServiceImpl: CalculatorService {
    public init() { }
    
    public func performOperation(_ operation: CalculatorOperation) -> AnyPublisher<String, CalculatorError> {
        return Future<String, CalculatorError> { [weak self] promise in
            guard let self else { return }
            
            let operand1 = operation.operand1
            
            switch operation.type {
            case .add:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                let result = operand1 + operand2
                promise(.success(formatResult(result)))
            case .subtract:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                let result = operand1 - operand2
                promise(.success(formatResult(result)))
            case .multiply:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                let result = operand1 * operand2
                promise(.success(formatResult(result)))
            case .divide:
                guard let operand2 = operation.operand2 else {
                    promise(.failure(.unknown))
                    return
                }
                if operand2 == 0 {
                    promise(.failure(.divideByZero))
                } else {
                    let result = operand1 / operand2
                    promise(.success(formatResult(result)))
                }
            case .sin:
                let result = sin(operand1)
                promise(.success(formatResult(result)))
            case .cos:
                let result = cos(operand1)
                promise(.success(formatResult(result)))
            }
        }
        .eraseToAnyPublisher()
    }

    private func formatResult(_ result: Double) -> String {
        if floor(result) == result {
            return "\(Int(result))"
        } else {
            return "\(result.rounded(toPlaces: 4))"
        }
    }
}

public extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
