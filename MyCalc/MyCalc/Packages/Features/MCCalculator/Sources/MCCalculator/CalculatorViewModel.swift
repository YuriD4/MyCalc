//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation
import Combine
import SwiftUI
import Networking
import Environment

final class CalculatorViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var inputString: String = ""
    @Published var errorMessage: String = ""
    @Published var operationButtonsEnabled: Bool = true
    @Published var equalButtonEnabled: Bool = false
    @Published var unaryOperationButtonsEnabled: Bool = true
    @Published var bitcoinButtonEnabled: Bool = true
    @Published var buttonsDisabledDueToError: Bool = false
    @Published var availableOperations: [CalculatorOperationType] = []
    
    private var calculatorService: CalculatorService
    private var featureToggleManager: CalcToggleManager
    private var operation: CalculatorOperationType?
    private var operand1: Double?
    private var cancellables = Set<AnyCancellable>()
    
    private var apiManager: APIManager
    private var networkManager: any NetworkReachabilityManager
    private var environment: APPEnvironment
    
    init(calculatorService: CalculatorService,
         featureToggleManager: CalcToggleManager,
         apiManager: APIManager,
         networkManager: any NetworkReachabilityManager,
         environment: APPEnvironment)
    {
        self.calculatorService = calculatorService
        self.featureToggleManager = featureToggleManager
        self.apiManager = apiManager
        self.networkManager = networkManager
        self.environment = environment
        
        setupBinding()
        setupReachabilityBinding()
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
        
        $errorMessage
        .removeDuplicates()
        .filter{ $0 != "" }
        .sink { [weak self] _ in
            self?.buttonsDisabledDueToError = true
        }
        .store(in: &cancellables)
    }
    
    private func setupReachabilityBinding() {
        networkManager.isConnectedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isConnected in
                guard let self else { return }
                
                if !isLoading {
                    bitcoinButtonEnabled = isConnected
                }
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
        buttonsDisabledDueToError = false
    }
    
    func inputNumber(_ number: Int) {
        guard !buttonsDisabledDueToError else { return }
        inputString.append("\(number)")
    }
    
    func inputDecimal() {
        guard !buttonsDisabledDueToError else { return }
        if !inputString.contains(".") && !inputString.isEmpty {
            inputString.append(".")
        }
    }
    
    func performOperation(_ operationType: CalculatorOperationType) {
        guard !buttonsDisabledDueToError else { return }
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
        guard !buttonsDisabledDueToError else { return }
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
        guard !buttonsDisabledDueToError else { return }
        if operation != nil && text.count > 1 {
            equalButtonEnabled = true
        } else {
            equalButtonEnabled = false
        }
    }
    
    func calculateBitcoinPrice() {
        guard let amount = Double(inputString) else {
            return
        }
        
        let request = BitcoinPriceRequest(environment: environment)
        isLoading = true
        
        apiManager.send(request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished: break
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
                isLoading = false
            } receiveValue: { [weak self] response in
                self?.isLoading = false
                if let price = Double(response.price) {
                    let totalPrice = price * amount
                    self?.inputString = "\(totalPrice)"
                }
            }
            .store(in: &cancellables)
    }
}



