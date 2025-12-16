import Foundation
import Combine

@MainActor
final class SavedMeasurementViewModel: ObservableObject {
    @Published var measurement: Measurement

    private weak var router: SavedMeasurementRouter?

    init(measurement: Measurement, router: SavedMeasurementRouter) {
        self.measurement = measurement
        self.router = router
    }

    func onBack() {
        router?.closeSavedMeasurement()
    }
}
