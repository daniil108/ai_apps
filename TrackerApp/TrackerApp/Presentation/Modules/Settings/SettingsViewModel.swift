import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var email: String

    private weak var router: SettingsRouter?

    init(email: String, router: SettingsRouter) {
        self.email = email
        self.router = router
    }

    func onDismiss() {
        router?.dismissSettings()
    }

    func onLogout() {
        router?.logout()
    }

    func onExport() {
        // Stub action for export
    }
}
