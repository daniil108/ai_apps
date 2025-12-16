import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    private let client: HTTPClient
    private let builder: RequestBuilding
    private let config: WeatherAPIConfig
    private let preferencesStore: PreferencesStore
    private let currentCache = TimedCache<String, CurrentWeather>()
    private let forecastCache = TimedCache<String, [ForecastEntry]>()
    private var cacheObserver: NSObjectProtocol?

    init(client: HTTPClient, builder: RequestBuilding, config: WeatherAPIConfig, preferencesStore: PreferencesStore) {
        self.client = client
        self.builder = builder
        self.config = config
        self.preferencesStore = preferencesStore
        cacheObserver = NotificationCenter.default.addObserver(forName: Notification.Name("cacheCleared"), object: nil, queue: .main) { [weak self] _ in
            self?.currentCache.clear()
            self?.forecastCache.clear()
        }
    }

    deinit {
        if let cacheObserver {
            NotificationCenter.default.removeObserver(cacheObserver)
        }
    }

    func fetchCurrentWeather(for location: Location, units: Units, language: String?) async throws -> CurrentWeather {
        let cacheKey = "weather-\(location.id)-\(units.rawValue)"
        let cacheEnabled = (try? await preferencesStore.getPreferences().cacheResponses) ?? true
        if cacheEnabled, let cached = currentCache.value(for: cacheKey) {
            return cached
        }
        let endpoint = OpenWeatherEndpoints.currentWeather(location: location, units: units, lang: language, config: config)
        let dto: CurrentWeatherDTO = try await performRequest(endpoint: endpoint)
        let mapped = CurrentWeatherMapper.map(dto)
        if cacheEnabled { currentCache.insert(mapped, for: cacheKey, ttl: 300) }
        return mapped
    }

    func fetchForecast(for location: Location, units: Units, language: String?) async throws -> [ForecastEntry] {
        let cacheKey = "forecast-\(location.id)-\(units.rawValue)"
        let cacheEnabled = (try? await preferencesStore.getPreferences().cacheResponses) ?? true
        if cacheEnabled, let cached = forecastCache.value(for: cacheKey) {
            return cached
        }
        let endpoint = OpenWeatherEndpoints.forecast(location: location, units: units, lang: language, config: config)
        let dto: ForecastDTO = try await performRequest(endpoint: endpoint)
        let mapped = ForecastMapper.map(dto)
        if cacheEnabled { forecastCache.insert(mapped, for: cacheKey, ttl: 1800) }
        return mapped
    }

    private func performRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let decoder = JSONDecoder()
        var attempt = 0
        let maxAttempts = 3

        while true {
            do {
                let request = try builder.buildRequest(for: endpoint)
                let (data, response) = try await client.send(request)
                guard 200..<300 ~= response.statusCode else {
                    if response.statusCode == 401 { throw DomainError.invalidAPIKey }
                    if response.statusCode == 429 { throw NetworkError.httpStatus(code: response.statusCode, body: data) }
                    if (500...599).contains(response.statusCode), attempt < maxAttempts - 1 {
                        attempt += 1
                        try await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(attempt)) * 200_000_000))
                        continue
                    }
                    throw NetworkError.httpStatus(code: response.statusCode, body: data)
                }
                return try decoder.decode(T.self, from: data)
            } catch let error as NetworkError {
                if case .transport(let urlError) = error, urlError.code == .timedOut, attempt < maxAttempts - 1 {
                    attempt += 1
                    try await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(attempt)) * 200_000_000))
                    continue
                }
                throw error
            } catch {
                if let urlError = error as? URLError, urlError.code == .timedOut, attempt < maxAttempts - 1 {
                    attempt += 1
                    try await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(attempt)) * 200_000_000))
                    continue
                }
                throw NetworkError.decoding(error)
            }
        }
    }
}
