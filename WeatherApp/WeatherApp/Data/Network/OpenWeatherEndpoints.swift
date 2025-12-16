import Foundation

struct OpenWeatherEndpoints {
    static func search(query: String, config: WeatherAPIConfig) -> Endpoint {
        Endpoint(
            baseURL: config.baseURLGeo,
            path: "/geo/1.0/direct",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "limit", value: "5")
            ]
        )
    }

    static func currentWeather(location: Location, units: Units, lang: String?, config: WeatherAPIConfig) -> Endpoint {
        var items = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)")
        ]
        items.append(URLQueryItem(name: "units", value: units.rawValue))
        if let lang { items.append(URLQueryItem(name: "lang", value: lang)) }
        return Endpoint(baseURL: config.baseURLWeather, path: "/data/2.5/weather", queryItems: items)
    }

    static func forecast(location: Location, units: Units, lang: String?, config: WeatherAPIConfig) -> Endpoint {
        var items = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "cnt", value: "40"),
            URLQueryItem(name: "units", value: units.rawValue)
        ]
        if let lang { items.append(URLQueryItem(name: "lang", value: lang)) }
        return Endpoint(baseURL: config.baseURLWeather, path: "/data/2.5/forecast", queryItems: items)
    }

    static func airQuality(location: Location, config: WeatherAPIConfig) -> Endpoint {
        let items = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)")
        ]
        return Endpoint(baseURL: config.baseURLWeather, path: "/data/2.5/air_pollution", queryItems: items)
    }
}
