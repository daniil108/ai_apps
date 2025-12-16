import Foundation

public protocol GetMeasurementsUseCase {
    func execute() async throws -> [Measurement]
}

public final class GetMeasurementsUseCaseImpl: GetMeasurementsUseCase {
    private let repository: MeasurementRepository

    public init(repository: MeasurementRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Measurement] {
        try await repository.fetchMeasurements()
    }
}
