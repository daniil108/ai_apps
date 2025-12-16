import Foundation

final class GeocodingRepositoryImpl: GeocodingRepository {
    private let client: HTTPClient
    private let builder: RequestBuilding
    private let config: WeatherAPIConfig

    init(client: HTTPClient, builder: RequestBuilding, config: WeatherAPIConfig) {
        self.client = client
        self.builder = builder
        self.config = config
    }

    func search(query: String, limit: Int) async throws -> [Location] {
        let endpoint = OpenWeatherEndpoints.search(query: query, config: config)
        let request = try builder.buildRequest(for: endpoint)
        let (data, response) = try await client.send(request)
        guard 200..<300 ~= response.statusCode else {
            throw NetworkError.httpStatus(code: response.statusCode, body: data)
        }
        let decoder = JSONDecoder()
        let dtos = try decoder.decode([GeocodingLocationDTO].self, from: data)
        return dtos.map(GeocodingMapper.map)
    }
}
