import Foundation

public struct User: Identifiable, Equatable, Codable {
    public let id: UUID
    public let email: String

    public init(id: UUID, email: String) {
        self.id = id
        self.email = email
    }
}
