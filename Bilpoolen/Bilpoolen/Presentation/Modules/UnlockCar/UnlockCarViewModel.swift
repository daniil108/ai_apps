import Foundation
import Combine

@MainActor
final class UnlockCarViewModel: ObservableObject {
    let booking: Booking
    private let router: NewBookingRouting

    init(booking: Booking, router: NewBookingRouting) {
        self.booking = booking
        self.router = router
    }

    func unlockAndStartTripTapped() {
        router.showLockCar(booking: booking)
    }
}
