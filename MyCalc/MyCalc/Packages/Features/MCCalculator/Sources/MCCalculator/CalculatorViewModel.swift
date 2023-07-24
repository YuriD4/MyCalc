//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Combine
import SwiftUI

import Foundation
import Combine
import SwiftUI

final class CalculatorViewModel: ObservableObject {
    @Published var inputString: String = ""
    @Published var errorMessage: String = "" {
        didSet {
            if !errorMessage.isEmpty {
                disableButtons()
            }
        }
    }
    @Published var operationButtonsEnabled: Bool = true
    @Published var equalButtonEnabled: Bool = false
    @Published var unaryOperationButtonsEnabled: Bool = true
    @Published var availableOperations: [CalculatorOperationType] = []
    
    private var calculatorService: CalculatorService
    private var featureToggleManager: CalcToggleManager
    private var operation: CalculatorOperationType?
    private var operand1: Double?
    private var cancellables = Set<AnyCancellable>()
    
    init(calculatorService: CalculatorService, featureToggleManager: CalcToggleManager) {
        self.calculatorService = calculatorService
        self.featureToggleManager = featureToggleManager
        
        setupBinding()
    }
    
    private func setupBinding() {
        featureToggleManager.availableOperations
            .sink { [weak self] operations in
                self?.availableOperations = operations
            }
            .store(in: &cancellables)
        
        $inputString
            .sink { [weak self] text in
                self?.parseInputString(text)
            }
            .store(in: &cancellables)
    }
    
    func clear() {
        inputString = ""
        errorMessage = ""
        operation = nil
        operand1 = nil
        operationButtonsEnabled = true
        unaryOperationButtonsEnabled = true
        equalButtonEnabled = false
    }
    
    func inputNumber(_ number: Int) {
        inputString.append("\(number)")
    }
    
    func inputDecimal() {
        if !inputString.contains(".") && !inputString.isEmpty {
            inputString.append(".")
        }
    }
    
    func performOperation(_ operationType: CalculatorOperationType) {
        operation = operationType
        if let inputNumber = Double(inputString) {
            operand1 = inputNumber
            inputString += operationType.description
            operationButtonsEnabled = false
            unaryOperationButtonsEnabled = operationType == .add || operationType == .subtract || operationType == .multiply || operationType == .divide
            equalButtonEnabled = false
            if operationType == .sin || operationType == .cos {
                calculateResult()
            }
        }
    }
    
    func calculateResult() {
        var operands = [inputString]
        if let op = operation {
            operands = inputString.split(separator: op.description.first!).map { String($0) }
        }
        
        if let operand1 = Double(operands[0]) {
            var operand2: Double? = nil
            if operands.count > 1 {
                operand2 = Double(operands[1])
            }
            let operationToPerform = CalculatorOperation(type: operation!, operand1: operand1, operand2: operand2)
            calculatorService.performOperation(operationToPerform)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    case .finished: break
                    }
                } receiveValue: { [weak self] result in
                    guard let self else { return }
                    
                    inputString = "\(result)"
                    operation = nil
                    self.operand1 = Double(inputString)
                    operationButtonsEnabled = true
                    unaryOperationButtonsEnabled = true
                    equalButtonEnabled = false
                }
                .store(in: &cancellables)
        }
    }
    
    private func parseInputString(_ text: String) {
        if operation != nil && text.count > 1 {
            equalButtonEnabled = true
        } else {
            equalButtonEnabled = false
        }
    }
    
    private func disableButtons() {
        operationButtonsEnabled = false
        equalButtonEnabled = false
        unaryOperationButtonsEnabled = false
    }
}



