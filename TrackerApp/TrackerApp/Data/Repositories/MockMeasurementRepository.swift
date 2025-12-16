import Foundation

public final class MockMeasurementRepository: MeasurementRepository {
    private var dataStore = MockDataStore()
    private let delayRange: ClosedRange<UInt64> = 300_000_000...800_000_000

    public init() {}

    public func fetchMeasurements() async throws -> [Measurement] {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 400_000_000)
        return dataStore.measurements.sorted { $0.timestamp > $1.timestamp }
    }

    public func startMeasurementStream() -> AsyncStream<MeasurementValues> {
        AsyncStream { continuation in
            Task.detached {
                var gauge = 1435.2
                var checkGauge = 1389.0
                var flangeway = 42.1
                var cant = 5.2
                var backToBack = 1340.3
                while !Task.isCancelled {
                    gauge += Double.random(in: -0.5...0.5)
                    checkGauge += Double.random(in: -0.3...0.3)
                    flangeway += Double.random(in: -0.2...0.2)
                    cant += Double.random(in: -0.2...0.2)
                    backToBack += Double.random(in: -0.4...0.4)
                    let values = MeasurementValues(
                        gauge: gauge.rounded(toPlaces: 1),
                        checkGauge: checkGauge.rounded(toPlaces: 1),
                        flangewayClearance: flangeway.rounded(toPlaces: 1),
                        cant: cant.rounded(toPlaces: 1),
                        backToBack: backToBack.rounded(toPlaces: 1)
                    )
                    continuation.yield(values)
                    try? await Task.sleep(nanoseconds: 700_000_000)
                }
                continuation.finish()
            }
        }
    }

    public func saveMeasurement(values: MeasurementValues, comment: String) async throws -> Measurement {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 500_000_000)
        let measurement = Measurement(id: UUID(), timestamp: Date(), values: values, comment: comment)
        dataStore.measurements.insert(measurement, at: 0)
        return measurement
    }
}

private extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
