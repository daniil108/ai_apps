import Foundation

struct SaveLastSelectedLocationUseCase {
    private let store: PreferencesStore

    init(store: PreferencesStore) {
        self.store = store
    }

    func execute(_ location: Location) async throws {
        try await store.saveLastLocation(location)
    }
}
