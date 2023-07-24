//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import Combine
import Networking

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
                
                HStack {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Button(action: { viewModel.calculateBitcoinPrice() }) {
                                Text("Bitcoin")
                            }
                            .padding()
                            .background(viewModel.bitcoinButtonEnabled ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(viewModel.bitcoinButtonEnabled ? 1 : 0.5)
                            .disabled(!viewModel.bitcoinButtonEnabled)
                        }
                        
                        if !viewModel.bitcoinButtonEnabled {
                            Text("No Network Connection")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { viewModel.clear() }) {
                        Text("Clear")
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
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
        CalculatorView(viewModel: CalculatorViewModel(calculatorService: CalculatorServiceImpl(), featureToggleManager: CalcToggleManagerImpl(), apiManager: APIManagerImpl(), networkManager: NetworkReachabilityManagerImpl(), environment: .prod))
    }
}
