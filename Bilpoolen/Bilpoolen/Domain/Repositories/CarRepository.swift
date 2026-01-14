import Foundation

protocol CarRepository {
    func fetchAvailableCars() async -> [Car]
}
