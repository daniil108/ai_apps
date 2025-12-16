import Foundation

protocol HTTPClient {
    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

final class URLSessionHTTPClient: HTTPClient {
    private let logger: NetworkLogger?

    init(logger: NetworkLogger? = nil) {
        self.logger = logger
    }

    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let start = Date()
        logger?.log("➡️ \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidURL
            }
            let duration = Date().timeIntervalSince(start)
            logger?.log("⬅️ [\(httpResponse.statusCode)] \(request.url?.absoluteString ?? "") (\(String(format: "%.2fs", duration)))")
            return (data, httpResponse)
        } catch {
            let duration = Date().timeIntervalSince(start)
            logger?.log("❌ \(request.url?.absoluteString ?? "") error after \(String(format: "%.2fs", duration)): \(error)")
            if let urlError = error as? URLError {
                if urlError.code == .cancelled { throw NetworkError.cancelled }
                throw NetworkError.transport(urlError)
            }
            throw error
        }
    }
}
