import Foundation

public protocol GetCurrentUserUseCase {
    func execute() async -> User?
}

public final class GetCurrentUserUseCaseImpl: GetCurrentUserUseCase {
    private let repository: SessionRepository

    public init(repository: SessionRepository) {
        self.repository = repository
    }

    public func execute() async -> User? {
        await repository.currentUser()
    }
}
