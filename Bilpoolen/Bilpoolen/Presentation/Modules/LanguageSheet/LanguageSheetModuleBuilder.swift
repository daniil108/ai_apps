import SwiftUI

struct LanguageSheetModuleBuilder {
    let container: AppContainer

    func build(router: SettingsRouting) -> some View {
        let viewModel = LanguageSheetViewModel(router: router)
        return LanguageSheetView(viewModel: viewModel)
    }
}
