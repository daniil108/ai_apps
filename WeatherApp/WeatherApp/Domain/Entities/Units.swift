import Foundation

enum Units: String, CaseIterable, Codable, Equatable {
    case metric
    case imperial
    case standard

    var displayName: String {
        switch self {
        case .metric: return "Metric"
        case .imperial: return "Imperial"
        case .standard: return "Standard"
        }
    }

    var temperatureSuffix: String {
        switch self {
        case .metric: return "°C"
        case .imperial: return "°F"
        case .standard: return "K"
        }
    }
}
