import Foundation

struct AirQualityMapper {
    static func map(_ dto: AirQualityDTO) -> AirQuality? {
        guard let first = dto.list.first else { return nil }
        return AirQuality(
            aqi: first.main.aqi,
            pm2_5: first.components.pm2_5,
            pm10: first.components.pm10,
            o3: first.components.o3,
            no2: first.components.no2,
            co: first.components.co,
            so2: first.components.so2,
            nh3: first.components.nh3,
            no: first.components.no,
            timestamp: Date(timeIntervalSince1970: first.dt)
        )
    }
}
