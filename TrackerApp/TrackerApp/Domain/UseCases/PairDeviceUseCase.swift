import Foundation

public protocol PairDeviceUseCase {
    func execute() async throws -> DeviceConnectionState
}

public final class PairDeviceUseCaseImpl: PairDeviceUseCase {
    private let repository: DeviceRepository

    public init(repository: DeviceRepository) {
        self.repository = repository
    }

    public func execute() async throws -> DeviceConnectionState {
        try await repository.pairDevice()
    }
}
