import Foundation

final class DIContainer {
    private var factories: [ObjectIdentifier: (DIContainer) -> Any] = [:]

    func register<Service>(_ type: Service.Type, factory: @escaping (DIContainer) -> Service) {
        let key = ObjectIdentifier(type)
        factories[key] = factory
    }

    func resolve<Service>(_ type: Service.Type) -> Service {
        let key = ObjectIdentifier(type)
        guard let factory = factories[key], let service = factory(self) as? Service else {
            fatalError("No registration for \(type)")
        }
        return service
    }
}
