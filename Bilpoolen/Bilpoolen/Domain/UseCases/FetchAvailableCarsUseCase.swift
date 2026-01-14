import Foundation

protocol FetchAvailableCarsUseCase {
    func execute() async -> [Car]
}

struct FetchAvailableCarsInteractor: FetchAvailableCarsUseCase {
    let repository: CarRepository

    func execute() async -> [Car] {
        await repository.fetchAvailableCars()
    }
}
