//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI

struct OperationPad: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        HStack {
            ForEach(viewModel.availableOperations, id: \.self) { operation in
                OperationButton(viewModel: viewModel, operation: operation)
            }
        }
    }
}

struct OperationButton: View {
    @ObservedObject var viewModel: CalculatorViewModel
    var operation: CalculatorOperationType
    
    var body: some View {
        Button(action: { viewModel.performOperation(operation) }) {
            Text(operation.description)
                .font(.body)
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
        }
        .disabled(!viewModel.operationButtonsEnabled)
    }
}

// Preview
struct OperationPad_Previews: PreviewProvider {
    static var previews: some View {
        OperationPad(viewModel: CalculatorViewModel(calculatorService: CalculatorServiceImpl(),         featureToggleManager: CalcToggleManagerImpl()))
    }
}
