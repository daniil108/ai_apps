import Foundation

struct GetCurrentWeatherUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(location: Location, units: Units, language: String?) async throws -> CurrentWeather {
        try await repository.fetchCurrentWeather(for: location, units: units, language: language)
    }
}
