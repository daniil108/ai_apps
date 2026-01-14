import Foundation
import Combine

@MainActor
final class MyBookingsViewModel: ObservableObject {
    @Published var activeBooking: Booking?
    @Published var upcomingBookings: [Booking] = []

    private let fetchBookingsUseCase: FetchBookingsUseCase
    private let router: MyBookingsRouting

    init(fetchBookingsUseCase: FetchBookingsUseCase, router: MyBookingsRouting) {
        self.fetchBookingsUseCase = fetchBookingsUseCase
        self.router = router
    }

    func onAppear() {
        Task {
            activeBooking = await fetchBookingsUseCase.fetchActive()
            upcomingBookings = await fetchBookingsUseCase.fetchUpcoming()
        }
    }

    func activeBookingTapped() {
        guard let booking = activeBooking else { return }
        router.showUnlockCar(booking: booking)
    }

    func upcomingBookingTapped(_ booking: Booking) {
        router.showUpcomingBooking(booking: booking)
    }
}
