import Foundation
import Combine

@MainActor
final class NewBookingViewModel: ObservableObject {
    enum SearchMode: Int, CaseIterable {
        case list
        case map
    }

    @Published var activeBooking: Booking?
    @Published var availableCars: [Car] = []
    @Published var isSearching = false
    @Published var hasConflict = false
    @Published var searchMode: SearchMode = .list

    private let fetchBookingsUseCase: FetchBookingsUseCase
    private let fetchAvailableCarsUseCase: FetchAvailableCarsUseCase
    private let router: NewBookingRouting

    init(
        fetchBookingsUseCase: FetchBookingsUseCase,
        fetchAvailableCarsUseCase: FetchAvailableCarsUseCase,
        router: NewBookingRouting
    ) {
        self.fetchBookingsUseCase = fetchBookingsUseCase
        self.fetchAvailableCarsUseCase = fetchAvailableCarsUseCase
        self.router = router
    }

    func onAppear() {
        Task {
            activeBooking = await fetchBookingsUseCase.fetchActive()
            availableCars = await fetchAvailableCarsUseCase.execute()
        }
    }

    func unlockAndStartTripTapped() {
        guard let booking = activeBooking else { return }
        router.showLockCar(booking: booking)
    }

    func searchTapped() {
        isSearching = true
        hasConflict = true
    }

    func advancedFiltersTapped() {
        router.showFilters()
    }

    func carTapped(_ car: Car) {
        router.showCarDetails(car: car)
    }

    func mapSelected() {
        router.showMap()
    }
}
