import Foundation

struct GeocodingMapper {
    static func map(_ dto: GeocodingLocationDTO) -> Location {
        Location(name: dto.name, country: dto.country, state: dto.state, latitude: dto.lat, longitude: dto.lon)
    }
}
