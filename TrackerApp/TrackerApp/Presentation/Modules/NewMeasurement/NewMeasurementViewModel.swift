import Foundation
import Combine

@MainActor
final class NewMeasurementViewModel: ObservableObject {
    @Published var values: MeasurementValues = MeasurementValues(gauge: 1435.2, checkGauge: 1389.0, flangewayClearance: 42.1, cant: 5.2, backToBack: 1340.3)
    @Published var comment: String = ""
    @Published var isSaving: Bool = false

    private let startMeasurementUseCase: StartMeasurementUseCase
    private let saveMeasurementUseCase: SaveMeasurementUseCase
    private weak var router: NewMeasurementRouter?
    private var streamTask: Task<Void, Never>?

    init(startMeasurementUseCase: StartMeasurementUseCase, saveMeasurementUseCase: SaveMeasurementUseCase, router: NewMeasurementRouter) {
        self.startMeasurementUseCase = startMeasurementUseCase
        self.saveMeasurementUseCase = saveMeasurementUseCase
        self.router = router
    }

    func onAppear() {
        guard streamTask == nil else { return }
        streamTask = Task {
            for await value in startMeasurementUseCase.execute() {
                await MainActor.run {
                    self.values = value
                }
            }
        }
    }

    func onDisappear() {
        streamTask?.cancel()
        streamTask = nil
    }

    func onSaveTapped() {
        Task { await save() }
    }

    private func save() async {
        isSaving = true
        do {
            _ = try await saveMeasurementUseCase.execute(values: values, comment: comment)
            router?.closeAfterSave()
        } catch {
            // Ignore for mock
        }
        isSaving = false
    }
}
