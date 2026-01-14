import Foundation

protocol FetchBookingsUseCase {
    func fetchActive() async -> Booking?
    func fetchUpcoming() async -> [Booking]
    func fetchPast() async -> [Booking]
}

struct FetchBookingsInteractor: FetchBookingsUseCase {
    let repository: BookingRepository

    func fetchActive() async -> Booking? {
        await repository.fetchActiveBooking()
    }

    func fetchUpcoming() async -> [Booking] {
        await repository.fetchUpcomingBookings()
    }

    func fetchPast() async -> [Booking] {
        await repository.fetchPastBookings()
    }
}
