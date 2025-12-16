import Foundation

struct Preferences: Codable, Equatable {
    var units: Units
    var useDeviceLanguage: Bool
    var customLanguageCode: String?
    var cacheResponses: Bool

    static var `default`: Preferences {
        Preferences(units: .metric, useDeviceLanguage: true, customLanguageCode: nil, cacheResponses: true)
    }
}
