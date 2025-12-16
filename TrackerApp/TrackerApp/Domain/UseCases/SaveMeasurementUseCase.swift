import Foundation

public protocol SaveMeasurementUseCase {
    func execute(values: MeasurementValues, comment: String) async throws -> Measurement
}

public final class SaveMeasurementUseCaseImpl: SaveMeasurementUseCase {
    private let repository: MeasurementRepository

    public init(repository: MeasurementRepository) {
        self.repository = repository
    }

    public func execute(values: MeasurementValues, comment: String) async throws -> Measurement {
        try await repository.saveMeasurement(values: values, comment: comment)
    }
}
