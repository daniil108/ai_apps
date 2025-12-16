import Foundation

struct GetPreferencesUseCase {
    private let store: PreferencesStore

    init(store: PreferencesStore) {
        self.store = store
    }

    func execute() async throws -> Preferences {
        try await store.getPreferences()
    }
}
