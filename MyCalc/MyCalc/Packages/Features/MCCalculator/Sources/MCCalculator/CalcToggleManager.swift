//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation

public protocol CalcToggleManager {
    var availableOperations: [CalculatorOperationType] { get }
}

public class CalcToggleManagerImpl: CalcToggleManager {
    public var availableOperations: [CalculatorOperationType] {
        return [.add, .subtract, .multiply, .divide, .sin, .cos]
    }
    
    public init() {
        
    }
}
