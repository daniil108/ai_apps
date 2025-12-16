import Foundation

protocol GeocodingRepository {
    func search(query: String, limit: Int) async throws -> [Location]
}
