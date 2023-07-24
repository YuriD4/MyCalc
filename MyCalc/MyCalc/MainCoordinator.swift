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

class MainCoordinator: Coordinator {
    @Published var children: [AnyCoordinator] = []
    
    private let environment: APPEnvironment
    
    private var calculatorCoordinator: CalculatorCoordinator
    private var settingsCoordinator: SettingsCoordinator
    
    init(environment: APPEnvironment) {
        self.environment = environment
        print(environment)
        calculatorCoordinator = CalculatorCoordinator(environment: environment)
        settingsCoordinator = SettingsCoordinator(environment: environment)
        children = [AnyCoordinator(calculatorCoordinator), AnyCoordinator(settingsCoordinator)]
    }
    
    func start() -> some View {
        TabViewContainer(calculatorCoordinator: calculatorCoordinator,
                         settingsCoordinator: settingsCoordinator)
        .environmentObject(self)
    }
}
