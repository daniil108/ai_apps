import Foundation

struct GetForecastUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(location: Location, units: Units, language: String?) async throws -> [ForecastEntry] {
        try await repository.fetchForecast(for: location, units: units, language: language)
    }
}
