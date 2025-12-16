import Foundation

public enum DomainError: Error, Equatable {
    case invalidCredentials
    case networkUnavailable
    case decodingFailed
    case unauthorized
    case deviceNotPaired
    case unknown(String)
}
