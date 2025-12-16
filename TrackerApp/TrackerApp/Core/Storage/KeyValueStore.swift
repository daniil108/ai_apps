import Foundation

public protocol KeyValueStore {
    func set(_ value: Data?, forKey key: String)
    func data(forKey key: String) -> Data?
}

public final class InMemoryKeyValueStore: KeyValueStore {
    private var storage: [String: Data] = [:]

    public init() {}

    public func set(_ value: Data?, forKey key: String) {
        storage[key] = value
    }

    public func data(forKey key: String) -> Data? {
        storage[key]
    }
}
