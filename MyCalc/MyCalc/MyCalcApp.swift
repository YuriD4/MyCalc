//
//  MyCalcApp.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import Environment

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
        
        _mainCoordinator = StateObject(wrappedValue: MainCoordinator(environment: environment))
    }
    
    var body: some Scene {
        WindowGroup {
            mainCoordinator.start()
        }
    }
}

