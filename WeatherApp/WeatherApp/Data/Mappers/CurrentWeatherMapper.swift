import Foundation

struct CurrentWeatherMapper {
    static func map(_ dto: CurrentWeatherDTO) -> CurrentWeather {
        let primary = dto.weather.first
        return CurrentWeather(
            temperature: dto.main.temp,
            feelsLike: dto.main.feels_like,
            minTemp: dto.main.temp_min,
            maxTemp: dto.main.temp_max,
            conditionMain: primary?.main ?? "",
            conditionDescription: primary?.description ?? "",
            iconId: primary?.icon ?? "",
            humidity: dto.main.humidity,
            pressure: dto.main.pressure,
            windSpeed: dto.wind.speed,
            windDegree: dto.wind.deg,
            windGust: dto.wind.gust,
            cloudiness: dto.clouds.all,
            rainLastHour: dto.rain?._1h,
            snowLastHour: dto.snow?._1h,
            sunrise: Date(timeIntervalSince1970: dto.sys.sunrise),
            sunset: Date(timeIntervalSince1970: dto.sys.sunset),
            timestamp: Date(timeIntervalSince1970: dto.dt),
            timezoneOffset: dto.timezone,
            locationName: dto.name
        )
    }
}
