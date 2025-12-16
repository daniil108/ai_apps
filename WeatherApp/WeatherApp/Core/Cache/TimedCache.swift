import Foundation

final class TimedCache<Key: Hashable, Value> {
    private struct CacheItem {
        let value: Value
        let expiry: Date
    }

    private var store: [Key: CacheItem] = [:]
    private let lock = NSLock()

    func insert(_ value: Value, for key: Key, ttl: TimeInterval) {
        lock.lock(); defer { lock.unlock() }
        store[key] = CacheItem(value: value, expiry: Date().addingTimeInterval(ttl))
    }

    func value(for key: Key) -> Value? {
        lock.lock(); defer { lock.unlock() }
        guard let item = store[key] else { return nil }
        if item.expiry < Date() {
            store[key] = nil
            return nil
        }
        return item.value
    }

    func clear() {
        lock.lock(); defer { lock.unlock() }
        store.removeAll()
    }
}
