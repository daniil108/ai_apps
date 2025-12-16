import Foundation

public final class MockSessionRepository: SessionRepository {
    private var user: User?

    public init() {}

    public func currentUser() async -> User? {
        user
    }

    public func setCurrentUser(_ user: User?) async {
        self.user = user
    }
}
