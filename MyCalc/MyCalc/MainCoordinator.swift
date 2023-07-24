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

class MainCoordinator: Coordinator {
    @Published var children: [AnyCoordinator] = []
    
    private var calculatorCoordinator: CalculatorCoordinator
    private var settingsCoordinator: SettingsCoordinator
    
    init() {
        calculatorCoordinator = CalculatorCoordinator()
        settingsCoordinator = SettingsCoordinator()
        children = [AnyCoordinator(calculatorCoordinator), AnyCoordinator(settingsCoordinator)]
    }
    
    func start() -> some View {
        TabViewContainer(calculatorCoordinator: calculatorCoordinator,
                         settingsCoordinator: settingsCoordinator)
        .environmentObject(self)
    }
}
