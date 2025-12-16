import Foundation

public protocol MeasurementRepository {
    func fetchMeasurements() async throws -> [Measurement]
    func startMeasurementStream() -> AsyncStream<MeasurementValues>
    func saveMeasurement(values: MeasurementValues, comment: String) async throws -> Measurement
}
