import Foundation

public protocol LoginUseCase {
    func execute(email: String, password: String) async throws -> User
}

public final class LoginUseCaseImpl: LoginUseCase {
    private let repository: AuthenticationRepository
    private let sessionRepository: SessionRepository

    public init(repository: AuthenticationRepository, sessionRepository: SessionRepository) {
        self.repository = repository
        self.sessionRepository = sessionRepository
    }

    public func execute(email: String, password: String) async throws -> User {
        let user = try await repository.login(email: email, password: password)
        await sessionRepository.setCurrentUser(user)
        return user
    }
}
