//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import SwiftUI

public protocol Coordinator: AnyObject, ObservableObject {
    var children: [AnyCoordinator] { get set }
    
    associatedtype Output: View
    func start() -> Output
}

public class AnyCoordinator: Coordinator {
    @Published public var children: [AnyCoordinator] = []
    
    private let _start: () -> AnyView
    
    public init<C: Coordinator>(_ coordinator: C) {
        self._start = { AnyView(coordinator.start()) }
        self.children = coordinator.children.map(AnyCoordinator.init)
    }
    
    public func start() -> some View {
        _start()
    }
}


