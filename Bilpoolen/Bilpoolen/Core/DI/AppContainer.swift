import Foundation

final class AppContainer {
    private let authRepository: AuthRepository
    private let bookingRepository: BookingRepository
    private let carRepository: CarRepository

    init(
        authRepository: AuthRepository = MockAuthRepository(),
        bookingRepository: BookingRepository = MockBookingRepository(),
        carRepository: CarRepository = MockCarRepository()
    ) {
        self.authRepository = authRepository
        self.bookingRepository = bookingRepository
        self.carRepository = carRepository
    }

    func makeLoginUseCase() -> LoginUseCase {
        LoginInteractor(repository: authRepository)
    }

    func makeFetchBookingsUseCase() -> FetchBookingsUseCase {
        FetchBookingsInteractor(repository: bookingRepository)
    }

    func makeFetchAvailableCarsUseCase() -> FetchAvailableCarsUseCase {
        FetchAvailableCarsInteractor(repository: carRepository)
    }
}
