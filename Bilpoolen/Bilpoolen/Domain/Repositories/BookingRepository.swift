import Foundation

protocol BookingRepository {
    func fetchActiveBooking() async -> Booking?
    func fetchUpcomingBookings() async -> [Booking]
    func fetchPastBookings() async -> [Booking]
}
