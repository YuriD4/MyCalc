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
        TabView {
            calculatorCoordinator.start()
                .tabItem {
                    Label("Calculator", systemImage: "")
                }

            settingsCoordinator.start()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .environmentObject(self)
    }
}
