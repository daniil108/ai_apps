import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let country: String
    let state: String?
    let latitude: Double
    let longitude: Double

    init(name: String, country: String, state: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.country = country
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.id = "\(latitude),\(longitude),\(name),\(country)".hashed()
    }
}

private extension String {
    func hashed() -> String {
        String(self.hashValue)
    }
}
