import SwiftUI

struct SettingsModuleBuilder {
    let container: AppContainer

    func build(router: SettingsRouting) -> some View {
        let viewModel = SettingsViewModel(router: router)
        return SettingsView(viewModel: viewModel)
    }
}
