import Foundation

protocol RequestBuilding {
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest
}

final class RequestBuilder: RequestBuilding {
    private let apiConfig: WeatherAPIConfig

    init(apiConfig: WeatherAPIConfig) {
        self.apiConfig = apiConfig
    }

    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard !apiConfig.apiKey.isEmpty else { throw NetworkError.missingAPIKey }
        var components = URLComponents(url: endpoint.baseURL.appending(path: endpoint.path), resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryItems + [URLQueryItem(name: "appid", value: apiConfig.apiKey)]
        guard let url = components?.url else { throw NetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { key, value in request.addValue(value, forHTTPHeaderField: key) }
        return request
    }
}
