import Foundation

protocol WeatherAPIConfig {
    var apiKey: String { get }
    var baseURLWeather: URL { get }
    var baseURLGeo: URL { get }
}

struct DefaultWeatherAPIConfig: WeatherAPIConfig {
    let apiKey: String = "e25324afb257bb282fee708940bf61d7"
    let baseURLWeather: URL = URL(string: "https://api.openweathermap.org")!
    let baseURLGeo: URL = URL(string: "https://api.openweathermap.org")!
}
