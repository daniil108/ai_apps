import Foundation

struct ForecastEntry: Equatable, Identifiable {
    let id = UUID()
    let timestamp: Date
    let temp: Double
    let feelsLike: Double
    let description: String
    let iconId: String
    let popPercent: Int
    let windSpeed: Double
    let timezoneOffset: Int
}
