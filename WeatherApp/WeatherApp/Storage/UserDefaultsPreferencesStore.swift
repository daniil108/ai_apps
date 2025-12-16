import Foundation

final class UserDefaultsPreferencesStore: PreferencesStore {
    private let defaults: UserDefaults
    private let preferencesKey = "preferences_key"
    private let lastLocationKey = "last_location_key"
    private let cacheClearedNotification = Notification.Name("cacheCleared")

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func getPreferences() async throws -> Preferences {
        if let data = defaults.data(forKey: preferencesKey), let preferences = try? JSONDecoder().decode(Preferences.self, from: data) {
            return preferences
        }
        return Preferences.default
    }

    func savePreferences(_ preferences: Preferences) async throws {
        let data = try JSONEncoder().encode(preferences)
        defaults.set(data, forKey: preferencesKey)
    }

    func getLastLocation() async throws -> Location? {
        guard let data = defaults.data(forKey: lastLocationKey) else { return nil }
        return try? JSONDecoder().decode(Location.self, from: data)
    }

    func saveLastLocation(_ location: Location) async throws {
        let data = try JSONEncoder().encode(location)
        defaults.set(data, forKey: lastLocationKey)
    }

    func clearCache() {
        NotificationCenter.default.post(name: cacheClearedNotification, object: nil)
    }
}
