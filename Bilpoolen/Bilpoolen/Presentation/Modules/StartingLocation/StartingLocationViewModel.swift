import Foundation
import Combine

@MainActor
final class StartingLocationViewModel: ObservableObject {
    private let router: SettingsRouting

    init(router: SettingsRouting) {
        self.router = router
    }

    func addNewTapped() {
        router.showStartingLocationNew()
    }
}
