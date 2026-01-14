import Foundation

final class MockBookingRepository: BookingRepository {
    func fetchActiveBooking() async -> Booking? {
        Booking(
            id: UUID(),
            car: MockData.cars[0],
            status: .active,
            startDate: MockData.date(hourOffset: -1),
            endDate: MockData.date(hourOffset: 3),
            locationName: "Hagagatan 19 (Riddarsporrgaraget)"
        )
    }

    func fetchUpcomingBookings() async -> [Booking] {
        [
            Booking(
                id: UUID(),
                car: MockData.cars[0],
                status: .upcoming,
                startDate: MockData.date(dayOffset: 1),
                endDate: MockData.date(dayOffset: 1, hourOffset: 4),
                locationName: "Hagagatan 19 (Riddarsporrgaraget)"
            ),
            Booking(
                id: UUID(),
                car: MockData.cars[1],
                status: .upcoming,
                startDate: MockData.date(dayOffset: 2),
                endDate: MockData.date(dayOffset: 2, hourOffset: 4),
                locationName: "Hagagatan 19 (Riddarsporrgaraget)"
            ),
            Booking(
                id: UUID(),
                car: MockData.cars[2],
                status: .upcoming,
                startDate: MockData.date(dayOffset: 3),
                endDate: MockData.date(dayOffset: 3, hourOffset: 4),
                locationName: "Hagagatan 19 (Riddarsporrgaraget)"
            )
        ]
    }

    func fetchPastBookings() async -> [Booking] {
        [
            Booking(
                id: UUID(),
                car: MockData.cars[0],
                status: .past,
                startDate: MockData.date(dayOffset: -5),
                endDate: MockData.date(dayOffset: -5, hourOffset: 3),
                locationName: "Hagagatan 19 (Riddarsporrgaraget)"
            ),
            Booking(
                id: UUID(),
                car: MockData.cars[2],
                status: .past,
                startDate: MockData.date(dayOffset: -9),
                endDate: MockData.date(dayOffset: -9, hourOffset: 2),
                locationName: "Hagagatan 19 (Riddarsporrgaraget)"
            )
        ]
    }
}
