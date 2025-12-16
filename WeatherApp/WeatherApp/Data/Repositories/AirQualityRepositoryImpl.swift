import Foundation

final class AirQualityRepositoryImpl: AirQualityRepository {
    private let client: HTTPClient
    private let builder: RequestBuilding
    private let config: WeatherAPIConfig
    private let preferencesStore: PreferencesStore
    private let cache = TimedCache<String, AirQuality>()
    private var cacheObserver: NSObjectProtocol?

    init(client: HTTPClient, builder: RequestBuilding, config: WeatherAPIConfig, preferencesStore: PreferencesStore) {
        self.client = client
        self.builder = builder
        self.config = config
        self.preferencesStore = preferencesStore
        cacheObserver = NotificationCenter.default.addObserver(forName: Notification.Name("cacheCleared"), object: nil, queue: .main) { [weak self] _ in
            self?.cache.clear()
        }
    }

    deinit {
        if let cacheObserver {
            NotificationCenter.default.removeObserver(cacheObserver)
        }
    }

    func fetchAirQuality(for location: Location) async throws -> AirQuality {
        let cacheKey = "air-\(location.id)"
        let cacheEnabled = (try? await preferencesStore.getPreferences().cacheResponses) ?? true
        if cacheEnabled, let cached = cache.value(for: cacheKey) {
            return cached
        }
        let endpoint = OpenWeatherEndpoints.airQuality(location: location, config: config)
        let decoder = JSONDecoder()
        let request = try builder.buildRequest(for: endpoint)
        let (data, response) = try await client.send(request)
        guard 200..<300 ~= response.statusCode else {
            if response.statusCode == 401 { throw DomainError.invalidAPIKey }
            if (500...599).contains(response.statusCode) {
                try await Task.sleep(nanoseconds: 300_000_000)
            }
            throw NetworkError.httpStatus(code: response.statusCode, body: data)
        }
        let dto = try decoder.decode(AirQualityDTO.self, from: data)
        guard let mapped = AirQualityMapper.map(dto) else { throw NetworkError.decoding(DomainError.custom("No AQI data")) }
        if cacheEnabled { cache.insert(mapped, for: cacheKey, ttl: 300) }
        return mapped
    }
}
