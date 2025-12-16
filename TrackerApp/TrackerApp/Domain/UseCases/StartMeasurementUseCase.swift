import Foundation

public protocol StartMeasurementUseCase {
    func execute() -> AsyncStream<MeasurementValues>
}

public final class StartMeasurementUseCaseImpl: StartMeasurementUseCase {
    private let repository: MeasurementRepository

    public init(repository: MeasurementRepository) {
        self.repository = repository
    }

    public func execute() -> AsyncStream<MeasurementValues> {
        repository.startMeasurementStream()
    }
}
