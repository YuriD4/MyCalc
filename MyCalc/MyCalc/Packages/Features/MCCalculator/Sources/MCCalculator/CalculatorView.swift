//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import Combine

struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("", text: $viewModel.inputString)
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                    .padding()
                    .font(.largeTitle)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                    .disabled(true)
                
                Button(action: { viewModel.clear() }) {
                    Text("Clear")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                
                NumberPad(viewModel: viewModel)
                
                OperationPad(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Calculator")
        }
    }
}

// Preview
struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel(calculatorService: CalculatorServiceImpl(), featureToggleManager: CalcToggleManagerImpl()))
    }
}
