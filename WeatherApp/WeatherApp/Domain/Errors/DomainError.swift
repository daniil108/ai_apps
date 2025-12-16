import Foundation

enum DomainError: Error, LocalizedError {
    case missingLocation
    case invalidAPIKey
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .missingLocation:
            return "Select a location to view weather."
        case .invalidAPIKey:
            return "API key is invalid or missing."
        case .custom(let message):
            return message
        }
    }
}
