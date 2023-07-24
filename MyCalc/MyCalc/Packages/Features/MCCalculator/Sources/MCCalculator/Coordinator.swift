//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI
import MCCoordinator

public final class CalculatorCoordinator: Coordinator {
    @Published public var children: [AnyCoordinator] = []
    
    public init() {}
    
    public func start() -> some View {
        ContentView()
            .environmentObject(self)
    }
}
