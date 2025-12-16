import Foundation

struct MockDataStore {
    var measurements: [Measurement] = [
        Measurement(
            id: UUID(),
            timestamp: ISO8601DateFormatter().date(from: "2025-09-18T20:30:00Z") ?? Date(),
            values: MeasurementValues(gauge: 1435.2, checkGauge: 1389.0, flangewayClearance: 42.1, cant: 5.2, backToBack: 1340.3),
            comment: "Some comment. Leo massa in elit vitae orci quam turpis sit nulla quam mi in nibh viverra odio volutpat ultricies blandit amet."
        ),
        Measurement(
            id: UUID(),
            timestamp: ISO8601DateFormatter().date(from: "2025-09-17T23:11:00Z") ?? Date(),
            values: MeasurementValues(gauge: 1435.2, checkGauge: 1389.0, flangewayClearance: 42.1, cant: 5.2, backToBack: 1340.3),
            comment: ""
        ),
        Measurement(
            id: UUID(),
            timestamp: ISO8601DateFormatter().date(from: "2025-09-01T13:00:00Z") ?? Date(),
            values: MeasurementValues(gauge: 1435.2, checkGauge: 1389.0, flangewayClearance: 42.1, cant: 5.2, backToBack: 1340.3),
            comment: ""
        ),
        Measurement(
            id: UUID(),
            timestamp: ISO8601DateFormatter().date(from: "2025-08-09T11:32:00Z") ?? Date(),
            values: MeasurementValues(gauge: 1435.2, checkGauge: 1389.0, flangewayClearance: 42.1, cant: 5.2, backToBack: 1340.3),
            comment: ""
        )
    ]
}
