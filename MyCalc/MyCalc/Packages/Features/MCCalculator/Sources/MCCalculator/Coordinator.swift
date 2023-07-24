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
    
    public init(environment: APPEnvironment,
                networkReachabilityManager: any NetworkReachabilityManager,
                featureToggleManager: CalcToggleManager,
                calculatorService: CalculatorService)
    {
        self.environment = environment
        self.networkReachabilityManager = networkReachabilityManager
        self.featureToggleManager = featureToggleManager
        self.calculatorService = calculatorService
    }
    
    public func start() -> some View {
        ContentView()
            .environmentObject(self)
    }
}
