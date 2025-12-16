import Foundation

public protocol LogoutUseCase {
    func execute() async
}

public final class LogoutUseCaseImpl: LogoutUseCase {
    private let sessionRepository: SessionRepository
    private let deviceRepository: DeviceRepository

    public init(sessionRepository: SessionRepository, deviceRepository: DeviceRepository) {
        self.sessionRepository = sessionRepository
        self.deviceRepository = deviceRepository
    }

    public func execute() async {
        await sessionRepository.setCurrentUser(nil)
        _ = deviceRepository.currentState()
    }
}
