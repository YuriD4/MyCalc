//
//  MainCoordinator.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import MCCoordinator
import MCCalculator
import MCSettings
import MCSharedUI
import Environment
import Networking

class MainCoordinator: Coordinator {
    @Published var children: [AnyCoordinator] = []
    
    var serviceLocator = ServiceLocator.shared
        
    private let environment: APPEnvironment
    
    private var calculatorCoordinator: CalculatorCoordinator
    private var settingsCoordinator: SettingsCoordinator
    
    init(environment: APPEnvironment) {
        self.environment = environment
        
        let networkReachabilityManager = serviceLocator.resolve((any NetworkReachabilityManager).self)
        
        calculatorCoordinator = CalculatorCoordinator(environment: environment, networkReachabilityManager: networkReachabilityManager)
        settingsCoordinator = SettingsCoordinator(environment: environment)
        
        children = [AnyCoordinator(calculatorCoordinator), AnyCoordinator(settingsCoordinator)]
    }
    
    func start() -> some View {
        TabViewContainer(calculatorCoordinator: calculatorCoordinator,
                         settingsCoordinator: settingsCoordinator)
        .environmentObject(self)
    }
}
