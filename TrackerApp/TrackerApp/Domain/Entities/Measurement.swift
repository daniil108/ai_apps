import Foundation

public struct MeasurementValues: Equatable, Hashable, Codable {
    public let gauge: Double
    public let checkGauge: Double
    public let flangewayClearance: Double
    public let cant: Double
    public let backToBack: Double

    public init(gauge: Double, checkGauge: Double, flangewayClearance: Double, cant: Double, backToBack: Double) {
        self.gauge = gauge
        self.checkGauge = checkGauge
        self.flangewayClearance = flangewayClearance
        self.cant = cant
        self.backToBack = backToBack
    }
}

public struct Measurement: Identifiable, Equatable, Codable, Hashable {
    public let id: UUID
    public let timestamp: Date
    public let values: MeasurementValues
    public let comment: String

    public init(id: UUID, timestamp: Date, values: MeasurementValues, comment: String) {
        self.id = id
        self.timestamp = timestamp
        self.values = values
        self.comment = comment
    }
}
