import Foundation

public protocol DeviceRepository {
    func pairDevice() async throws -> DeviceConnectionState
    func currentState() -> DeviceConnectionState
}
