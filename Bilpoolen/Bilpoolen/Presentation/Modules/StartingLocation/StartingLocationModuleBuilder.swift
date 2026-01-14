import SwiftUI

struct StartingLocationModuleBuilder {
    let container: AppContainer

    func build(router: SettingsRouting) -> some View {
        let viewModel = StartingLocationViewModel(router: router)
        return StartingLocationView(viewModel: viewModel)
    }
}
