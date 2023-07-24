//
//  MyCalcApp.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI

@main
struct MyCalcApp: App {
    @StateObject private var mainCoordinator = MainCoordinator()
    private let serviceLocator = ServiceLocator.shared

    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            mainCoordinator.start()
        }
    }
}

