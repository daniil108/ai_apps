import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case missingAPIKey
    case transport(URLError)
    case httpStatus(code: Int, body: Data?)
    case decoding(Error)
    case cancelled

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .missingAPIKey:
            return "API key is missing."
        case .transport(let error):
            return error.localizedDescription
        case .httpStatus(let code, _):
            return "Request failed with status code \(code)."
        case .decoding:
            return "Failed to decode server response."
        case .cancelled:
            return "Request was cancelled."
        }
    }
}
