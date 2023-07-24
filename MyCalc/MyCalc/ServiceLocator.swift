//
//  ServiceLocator.swift
//  MyCalc
//
//  Created by Yuri Chukhlib on 24.07.2023.
//

import Foundation

enum ServiceLifetime {
    case singleton
    case singleInstance
}

struct Service {
    let lifetime: ServiceLifetime
    let factory: () -> Any
}

final class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    private var services: [ObjectIdentifier : Any] = [:]
    private var configuration: [ObjectIdentifier : Service] = [:]

    private init() {}
    
    func register<T>(_ serviceType: T.Type, lifetime: ServiceLifetime, factory: @escaping () -> T) {
        let key = ObjectIdentifier(serviceType)
        configuration[key] = Service(lifetime: lifetime, factory: factory)
    }

    func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(T.self)
        if let instance = services[key] as? T {
            return instance
        } else if let service = configuration[key] {
            let instance = service.factory() as! T
            if service.lifetime == .singleton {
                services[key] = instance
            }
            return instance
        } else {
            fatalError("No registered service for \(T.self)")
        }
    }
}

@propertyWrapper
struct Injected<T> {
    private let service: T

    init() {
        self.service = ServiceLocator.shared.resolve(T.self)
    }

    var wrappedValue: T {
        return service
    }
}

