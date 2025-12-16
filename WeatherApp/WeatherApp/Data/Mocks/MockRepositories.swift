import Foundation

struct MockDataFactory {
    static let sampleLocation = Location(name: "San Francisco", country: "US", state: "CA", latitude: 37.7749, longitude: -122.4194)
    static let sampleWeather = CurrentWeather(
        temperature: 18.2,
        feelsLike: 18.0,
        minTemp: 16.0,
        maxTemp: 21.0,
        conditionMain: "Clouds",
        conditionDescription: "broken clouds",
        iconId: "04d",
        humidity: 72,
        pressure: 1015,
        windSpeed: 5.4,
        windDegree: 240,
        windGust: 7.0,
        cloudiness: 75,
        rainLastHour: nil,
        snowLastHour: nil,
        sunrise: Date(),
        sunset: Date().addingTimeInterval(3600 * 6),
        timestamp: Date(),
        timezoneOffset: -25200,
        locationName: "San Francisco"
    )
    static let sampleForecast: [ForecastEntry] = (0..<8).map { index in
        ForecastEntry(
            timestamp: Date().addingTimeInterval(Double(index) * 3 * 3600),
            temp: 17 + Double(index) * 0.5,
            feelsLike: 17,
            description: "Cloudy",
            iconId: "04d",
            popPercent: 10 + index,
            windSpeed: 4.0 + Double(index) * 0.3,
            timezoneOffset: -25200
        )
    }
    static let sampleAQ = AirQuality(aqi: 2, pm2_5: 10, pm10: 15, o3: 18, no2: 12, co: 0.3, so2: 2.1, nh3: 1.2, no: 0.5, timestamp: Date())
}

final class MockWeatherRepository: WeatherRepository {
    func fetchCurrentWeather(for location: Location, units: Units, language: String?) async throws -> CurrentWeather {
        MockDataFactory.sampleWeather
    }

    func fetchForecast(for location: Location, units: Units, language: String?) async throws -> [ForecastEntry] {
        MockDataFactory.sampleForecast
    }
}

final class MockGeocodingRepository: GeocodingRepository {
    func search(query: String, limit: Int) async throws -> [Location] {
        [MockDataFactory.sampleLocation]
    }
}

final class MockAirQualityRepository: AirQualityRepository {
    func fetchAirQuality(for location: Location) async throws -> AirQuality {
        MockDataFactory.sampleAQ
    }
}

final class MockPreferencesStore: PreferencesStore {
    private var preferences = Preferences.default
    private var lastLocation: Location? = MockDataFactory.sampleLocation
    func getPreferences() async throws -> Preferences { preferences }
    func savePreferences(_ preferences: Preferences) async throws { self.preferences = preferences }
    func getLastLocation() async throws -> Location? { lastLocation }
    func saveLastLocation(_ location: Location) async throws { lastLocation = location }
    func clearCache() { }
}
