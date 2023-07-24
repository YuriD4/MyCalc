//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Combine

public protocol CalcToggleManager {
    var availableOperations: CurrentValueSubject<[CalculatorOperationType], Never> { get }
}

public class CalcToggleManagerImpl: CalcToggleManager {
    public var availableOperations = CurrentValueSubject<[CalculatorOperationType], Never>([.add, .subtract, .multiply, .divide, .sin, .cos])
    
    public init() {
        
    }
}

