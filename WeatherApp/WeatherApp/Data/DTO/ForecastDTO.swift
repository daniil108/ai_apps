import Foundation

struct ForecastDTO: Codable {
    struct Entry: Codable {
        struct Main: Codable {
            let temp: Double
            let feels_like: Double
            let humidity: Int
            let pressure: Int
        }
        struct Weather: Codable {
            let main: String
            let description: String
            let icon: String
        }
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double?
        }
        let dt: TimeInterval
        let main: Main
        let weather: [Weather]
        let wind: Wind
        let pop: Double
        let dt_txt: String
    }

    struct City: Codable {
        let name: String
        let country: String
        let timezone: Int
        let sunrise: TimeInterval?
        let sunset: TimeInterval?
    }

    let list: [Entry]
    let city: City
}
