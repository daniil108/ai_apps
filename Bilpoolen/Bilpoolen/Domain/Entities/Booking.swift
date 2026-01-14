import Foundation

struct Booking: Identifiable, Equatable, Hashable {
    let id: UUID
    let car: Car
    let status: BookingStatus
    let startDate: Date
    let endDate: Date
    let locationName: String
}

enum BookingStatus: String, Equatable, Hashable {
    case active
    case upcoming
    case past
}
