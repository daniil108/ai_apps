import Foundation

struct GetLastSelectedLocationUseCase {
    private let store: PreferencesStore

    init(store: PreferencesStore) {
        self.store = store
    }

    func execute() async throws -> Location? {
        try await store.getLastLocation()
    }
}
