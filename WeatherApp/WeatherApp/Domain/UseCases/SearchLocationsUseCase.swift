import Foundation

struct SearchLocationsUseCase {
    private let repository: GeocodingRepository

    init(repository: GeocodingRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [Location] {
        try await repository.search(query: query, limit: 5)
    }
}
