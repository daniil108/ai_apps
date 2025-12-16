import Foundation

public protocol RestorePasswordUseCase {
    func execute(email: String) async throws
}

public final class RestorePasswordUseCaseImpl: RestorePasswordUseCase {
    private let repository: AuthenticationRepository

    public init(repository: AuthenticationRepository) {
        self.repository = repository
    }

    public func execute(email: String) async throws {
        try await repository.restorePassword(email: email)
    }
}
