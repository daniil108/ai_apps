import Foundation

public protocol AuthenticationRepository {
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String) async throws -> User
    func restorePassword(email: String) async throws
}
