import Foundation

final class MockAuthRepository: AuthRepository {
    func login(email: String, password: String) async throws -> User {
        guard !email.isEmpty, !password.isEmpty else {
            throw AppError.invalidCredentials
        }
        return User(id: UUID(), email: email, fullName: "Daniil Sentsov")
    }

    func logout() async {
    }
}
