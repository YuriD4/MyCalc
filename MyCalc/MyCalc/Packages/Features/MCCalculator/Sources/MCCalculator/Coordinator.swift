//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import MCCoordinator
import Environment
import Networking

public final class CalculatorCoordinator: Coordinator {
    @Published public var children: [AnyCoordinator] = []
    
    private let environment: APPEnvironment
    private let networkReachabilityManager: any NetworkReachabilityManager
    private let featureToggleManager: CalcToggleManager
    private let calculatorService: CalculatorService
    private let apiManager: APIManager
    
    public init(environment: APPEnvironment,
                networkReachabilityManager: any NetworkReachabilityManager,
                featureToggleManager: CalcToggleManager,
                calculatorService: CalculatorService,
                apiManager: APIManager)
    {
        self.environment = environment
        self.networkReachabilityManager = networkReachabilityManager
        self.featureToggleManager = featureToggleManager
        self.calculatorService = calculatorService
        self.apiManager = apiManager
    }
    
    public func start() -> some View {
        CalculatorView(viewModel: .init(calculatorService: calculatorService,
                                        featureToggleManager: featureToggleManager,
                                        apiManager: apiManager,
                                        networkManager: networkReachabilityManager,
                                        environment: environment))
    }
}
