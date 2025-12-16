import Foundation

struct GetAirQualityUseCase {
    private let repository: AirQualityRepository

    init(repository: AirQualityRepository) {
        self.repository = repository
    }

    func execute(location: Location) async throws -> AirQuality {
        try await repository.fetchAirQuality(for: location)
    }
}
