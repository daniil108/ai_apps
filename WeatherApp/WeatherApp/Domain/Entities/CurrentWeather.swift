import Foundation

struct CurrentWeather: Equatable {
    let temperature: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let conditionMain: String
    let conditionDescription: String
    let iconId: String
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let windDegree: Double
    let windGust: Double?
    let cloudiness: Int
    let rainLastHour: Double?
    let snowLastHour: Double?
    let sunrise: Date
    let sunset: Date
    let timestamp: Date
    let timezoneOffset: Int
    let locationName: String
}
