import Foundation

struct SavePreferencesUseCase {
    private let store: PreferencesStore

    init(store: PreferencesStore) {
        self.store = store
    }

    func execute(_ preferences: Preferences) async throws {
        try await store.savePreferences(preferences)
    }
}
