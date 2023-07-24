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
    
    public init(environment: APPEnvironment, networkReachabilityManager: any NetworkReachabilityManager) {
        self.environment = environment
        self.networkReachabilityManager = networkReachabilityManager
    }
    
    public func start() -> some View {
        ContentView()
            .environmentObject(self)
    }
}
