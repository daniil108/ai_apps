import Foundation

public final class MockDeviceRepository: DeviceRepository {
    private var state: DeviceConnectionState = .notConnected
    private let delayRange: ClosedRange<UInt64> = 300_000_000...800_000_000

    public init() {}

    public func pairDevice() async throws -> DeviceConnectionState {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 500_000_000)
        state = .connected
        return state
    }

    public func currentState() -> DeviceConnectionState {
        state
    }
}
