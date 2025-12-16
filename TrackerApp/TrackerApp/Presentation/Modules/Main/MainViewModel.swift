import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @Published var connectionState: DeviceConnectionState
    @Published var measurements: [Measurement] = []
    @Published var isLoading: Bool = false

    private let pairDeviceUseCase: PairDeviceUseCase
    private let getMeasurementsUseCase: GetMeasurementsUseCase
    private let deviceRepository: DeviceRepository
    private weak var router: MainRouter?

    init(
        pairDeviceUseCase: PairDeviceUseCase,
        getMeasurementsUseCase: GetMeasurementsUseCase,
        deviceRepository: DeviceRepository,
        router: MainRouter
    ) {
        self.pairDeviceUseCase = pairDeviceUseCase
        self.getMeasurementsUseCase = getMeasurementsUseCase
        self.deviceRepository = deviceRepository
        self.router = router
        self.connectionState = deviceRepository.currentState()
    }

    func onAppear() {
        Task { await loadMeasurements() }
    }

    func onPairTapped() {
        Task { await pair() }
    }

    func onNewMeasurement() {
        router?.startNewMeasurement()
    }

    func onSelectMeasurement(_ measurement: Measurement) {
        router?.openMeasurement(measurement)
    }

    func onShowSettings() {
        router?.showSettings()
    }

    private func pair() async {
        isLoading = true
        do {
            connectionState = try await pairDeviceUseCase.execute()
        } catch {
            connectionState = .notConnected
        }
        isLoading = false
    }

    private func loadMeasurements() async {
        isLoading = true
        do {
            measurements = try await getMeasurementsUseCase.execute()
        } catch {
            measurements = []
        }
        isLoading = false
    }
}
