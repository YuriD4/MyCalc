//
//  MyCalcApp.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import Environment
import Networking
import MCCalculator

@main
struct MyCalcApp: App {
    @StateObject private var mainCoordinator: MainCoordinator
    private let serviceLocator = ServiceLocator.shared

    init() {
        var environment: APPEnvironment
        #if DEBUG
        environment = .dev
        #else
        environment = .prod
        #endif
        
        ServiceLocator.shared.register((any NetworkReachabilityManager).self, lifetime: .singleton, factory: { NetworkReachabilityManagerImpl() })
        ServiceLocator.shared.register(CalculatorService.self, lifetime: .singleInstance, factory: { CalculatorServiceImpl() })
        ServiceLocator.shared.register(CalcToggleManager.self, lifetime: .singleInstance, factory: { CalcToggleManagerImpl() })
        ServiceLocator.shared.register(APIManager.self, lifetime: .singleInstance, factory: { APIManagerImpl() })
        
        _mainCoordinator = StateObject(wrappedValue: MainCoordinator(environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            mainCoordinator.start()
        }
    }
}

