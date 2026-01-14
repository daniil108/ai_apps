import Foundation

protocol LoginUseCase {
    func execute(email: String, password: String) async throws -> User
}

struct LoginInteractor: LoginUseCase {
    let repository: AuthRepository

    func execute(email: String, password: String) async throws -> User {
        try await repository.login(email: email, password: password)
    }
}
