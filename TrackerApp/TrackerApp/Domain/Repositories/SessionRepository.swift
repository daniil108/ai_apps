import Foundation

public protocol SessionRepository {
    func currentUser() async -> User?
    func setCurrentUser(_ user: User?) async
}
