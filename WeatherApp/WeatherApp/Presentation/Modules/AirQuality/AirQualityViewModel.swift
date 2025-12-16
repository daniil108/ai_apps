import SwiftUI
import Combine

@MainActor
final class AirQualityViewModel: ObservableObject {
    enum State {
        case loading
        case empty
        case loaded(AirQuality, Location)
        case error(String)
    }

    @Published var state: State = .loading

    private let getAirQuality: GetAirQualityUseCase
    private let getLastLocation: GetLastSelectedLocationUseCase
    private weak var router: AirQualityRouting?

    init(getAirQuality: GetAirQualityUseCase, getLastLocation: GetLastSelectedLocationUseCase, router: AirQualityRouting) {
        self.getAirQuality = getAirQuality
        self.getLastLocation = getLastLocation
        self.router = router
    }

    func onAppear() {
        Task { await load() }
    }

    func refresh() { Task { await load() } }
    func backTapped() { router?.dismiss() }

    private func load() async {
        state = .loading
        do {
            guard let location = try await getLastLocation.execute() else {
                state = .empty
                return
            }
            let aq = try await getAirQuality.execute(location: location)
            state = .loaded(aq, location)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
