//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Network
import Combine

public protocol NetworkReachabilityManager {
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}

public class NetworkReachabilityManagerImpl: NetworkReachabilityManager {
    @Published public private(set) var isConnected = true
    private let monitor = NWPathMonitor()

    public var isConnectedPublisher: AnyPublisher<Bool, Never> {
        $isConnected.eraseToAnyPublisher()
    }

    public init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}



