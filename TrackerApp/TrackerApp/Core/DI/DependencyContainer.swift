import Foundation

public final class DependencyContainer {
    private var factories: [ObjectIdentifier: () -> Any] = [:]

    public init() {}

    public func register<Service>(_ type: Service.Type, factory: @escaping () -> Service) {
        factories[ObjectIdentifier(type)] = factory
    }

    public func resolve<Service>(_ type: Service.Type) -> Service {
        let key = ObjectIdentifier(type)
        guard let service = factories[key]?() as? Service else {
            fatalError("Dependency for \(type) not found")
        }
        return service
    }
}
