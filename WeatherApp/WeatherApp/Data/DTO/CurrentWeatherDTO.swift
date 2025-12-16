import Foundation

struct CurrentWeatherDTO: Codable {
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Double
        let gust: Double?
    }

    struct Clouds: Codable { let all: Int }
    struct Rain: Codable { let _1h: Double?
        private enum CodingKeys: String, CodingKey { case _1h = "1h" }
    }
    struct Snow: Codable { let _1h: Double?
        private enum CodingKeys: String, CodingKey { case _1h = "1h" }
    }
    struct Sys: Codable { let sunrise: TimeInterval; let sunset: TimeInterval }

    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let rain: Rain?
    let snow: Snow?
    let name: String
    let dt: TimeInterval
    let timezone: Int
    let sys: Sys
}
