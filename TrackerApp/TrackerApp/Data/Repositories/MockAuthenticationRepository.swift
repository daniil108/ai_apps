import Foundation

public final class MockAuthenticationRepository: AuthenticationRepository {
    private let delayRange: ClosedRange<UInt64> = 300_000_000...800_000_000
    private var registeredEmails: Set<String> = ["johndoe@example.com"]

    public init() {}

    public func login(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 400_000_000)
        guard registeredEmails.contains(email.lowercased()), !password.isEmpty else {
            throw DomainError.invalidCredentials
        }
        return User(id: UUID(), email: email)
    }

    public func register(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 400_000_000)
        guard !password.isEmpty else { throw DomainError.invalidCredentials }
        registeredEmails.insert(email.lowercased())
        return User(id: UUID(), email: email)
    }

    public func restorePassword(email: String) async throws {
        try await Task.sleep(nanoseconds: delayRange.randomElement() ?? 400_000_000)
        registeredEmails.insert(email.lowercased())
    }
}
