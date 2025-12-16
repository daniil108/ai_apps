import SwiftUI

enum SettingsModuleBuilder {
    static func build(container: DependencyContainer, router: SettingsRouter, userEmail: String) -> some View {
        let viewModel = SettingsViewModel(email: userEmail, router: router)
        return SettingsView(viewModel: viewModel)
    }
}
