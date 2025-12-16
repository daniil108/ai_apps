import Foundation

protocol PreferencesStore {
    func getPreferences() async throws -> Preferences
    func savePreferences(_ preferences: Preferences) async throws
    func getLastLocation() async throws -> Location?
    func saveLastLocation(_ location: Location) async throws
    func clearCache()
}
