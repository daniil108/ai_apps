import Foundation

protocol AirQualityRepository {
    func fetchAirQuality(for location: Location) async throws -> AirQuality
}
