//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import MCCoordinator
import Environment

public final class CalculatorCoordinator: Coordinator {
    @Published public var children: [AnyCoordinator] = []
    
    private let environment: APPEnvironment
    
    public init(environment: APPEnvironment) {
        self.environment = environment
    }
    
    public func start() -> some View {
        ContentView()
            .environmentObject(self)
    }
}
