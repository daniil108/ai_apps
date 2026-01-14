import Foundation

final class MockCarRepository: CarRepository {
    func fetchAvailableCars() async -> [Car] {
        MockData.cars
    }
}
