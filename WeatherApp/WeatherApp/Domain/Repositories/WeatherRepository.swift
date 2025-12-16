import Foundation

protocol WeatherRepository {
    func fetchCurrentWeather(for location: Location, units: Units, language: String?) async throws -> CurrentWeather
    func fetchForecast(for location: Location, units: Units, language: String?) async throws -> [ForecastEntry]
}
