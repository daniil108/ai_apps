import Foundation

struct ForecastMapper {
    static func map(_ dto: ForecastDTO) -> [ForecastEntry] {
        dto.list.map { entry in
            let primary = entry.weather.first
            return ForecastEntry(
                timestamp: Date(timeIntervalSince1970: entry.dt),
                temp: entry.main.temp,
                feelsLike: entry.main.feels_like,
                description: primary?.description ?? "",
                iconId: primary?.icon ?? "",
                popPercent: Int((entry.pop * 100).rounded()),
                windSpeed: entry.wind.speed,
                timezoneOffset: dto.city.timezone
            )
        }
    }
}
