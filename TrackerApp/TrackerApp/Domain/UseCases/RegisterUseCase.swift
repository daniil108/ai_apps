import Foundation

public protocol RegisterUseCase {
    func execute(email: String, password: String) async throws -> User
}

public final class RegisterUseCaseImpl: RegisterUseCase {
    private let repository: AuthenticationRepository
    private let sessionRepository: SessionRepository

    public init(repository: AuthenticationRepository, sessionRepository: SessionRepository) {
        self.repository = repository
        self.sessionRepository = sessionRepository
    }

    public func execute(email: String, password: String) async throws -> User {
        let user = try await repository.register(email: email, password: password)
        await sessionRepository.setCurrentUser(user)
        return user
    }
}
