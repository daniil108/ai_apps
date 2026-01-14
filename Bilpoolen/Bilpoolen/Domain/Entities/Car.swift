import Foundation

struct Car: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let plateNumber: String
    let locationName: String
    let distanceText: String
}
