import Foundation
import Combine

@MainActor
final class MapViewModel: ObservableObject {
    @Published var cars: [Car] = []

    private let fetchAvailableCarsUseCase: FetchAvailableCarsUseCase
    private let router: NewBookingRouting

    init(fetchAvailableCarsUseCase: FetchAvailableCarsUseCase, router: NewBookingRouting) {
        self.fetchAvailableCarsUseCase = fetchAvailableCarsUseCase
        self.router = router
    }

    func onAppear() {
        Task {
            cars = await fetchAvailableCarsUseCase.execute()
        }
    }

    func carTapped(_ car: Car) {
        router.showCarDetails(car: car)
    }
}
