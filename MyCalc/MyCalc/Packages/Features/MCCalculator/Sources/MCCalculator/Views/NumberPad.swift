//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import Networking

struct NumberPad: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(1..<4) { col in
                        NumberButton(viewModel: viewModel, number: row * 3 + col)
                    }
                }
            }
            HStack {
                NumberButton(viewModel: viewModel, number: 0)
                Button(action: { viewModel.inputDecimal() }) {
                    Text(".")
                        .font(.largeTitle)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .cornerRadius(32)
                }
                Button(action: { viewModel.calculateResult() }) {
                    Text("=")
                        .font(.largeTitle)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                        .background(viewModel.equalButtonEnabled ? Color.blue : Color.gray)
                        .cornerRadius(32)
                }
                .disabled(!viewModel.equalButtonEnabled)
            }
        }
    }
}

struct NumberButton: View {
    @ObservedObject var viewModel: CalculatorViewModel
    var number: Int
    
    var body: some View {
        Button(action: { viewModel.inputNumber(number) }) {
            Text("\(number)")
                .font(.largeTitle)
                .frame(width: 64, height: 64)
                .foregroundColor(.blue)
                .background(Color.white)
                .cornerRadius(32)
        }
    }
}

// Preview
struct NumberPad_Previews: PreviewProvider {
    static var previews: some View {
        NumberPad(viewModel: CalculatorViewModel(calculatorService: CalculatorServiceImpl(), featureToggleManager: CalcToggleManagerImpl(), apiManager: APIManagerImpl(), networkManager: NetworkReachabilityManagerImpl(), environment: .prod))
    }
}
