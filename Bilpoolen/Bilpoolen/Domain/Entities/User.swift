import Foundation

struct User: Identifiable, Equatable, Hashable {
    let id: UUID
    let email: String
    let fullName: String
}
