import Foundation

enum MockRegistrar {
    static func register(in container: DependencyContainer) {
        container.register(AuthenticationRepository.self) { MockAuthenticationRepository() }
        container.register(SessionRepository.self) { MockSessionRepository() }
        container.register(DeviceRepository.self) { MockDeviceRepository() }
        container.register(MeasurementRepository.self) { MockMeasurementRepository() }
        container.register(LoginUseCase.self) {
            LoginUseCaseImpl(
                repository: container.resolve(AuthenticationRepository.self),
                sessionRepository: container.resolve(SessionRepository.self)
            )
        }
        container.register(RegisterUseCase.self) {
            RegisterUseCaseImpl(
                repository: container.resolve(AuthenticationRepository.self),
                sessionRepository: container.resolve(SessionRepository.self)
            )
        }
        container.register(RestorePasswordUseCase.self) {
            RestorePasswordUseCaseImpl(repository: container.resolve(AuthenticationRepository.self))
        }
        container.register(LogoutUseCase.self) {
            LogoutUseCaseImpl(
                sessionRepository: container.resolve(SessionRepository.self),
                deviceRepository: container.resolve(DeviceRepository.self)
            )
        }
        container.register(GetCurrentUserUseCase.self) {
            GetCurrentUserUseCaseImpl(repository: container.resolve(SessionRepository.self))
        }
        container.register(PairDeviceUseCase.self) {
            PairDeviceUseCaseImpl(repository: container.resolve(DeviceRepository.self))
        }
        container.register(GetMeasurementsUseCase.self) {
            GetMeasurementsUseCaseImpl(repository: container.resolve(MeasurementRepository.self))
        }
        container.register(StartMeasurementUseCase.self) {
            StartMeasurementUseCaseImpl(repository: container.resolve(MeasurementRepository.self))
        }
        container.register(SaveMeasurementUseCase.self) {
            SaveMeasurementUseCaseImpl(repository: container.resolve(MeasurementRepository.self))
        }
        container.register(Logger.self) { ConsoleLogger() }
    }
}
