import SwiftUI

enum SettingsBuilder {
    static func build(container: DIContainer, router: SettingsRouting, apiConfig: WeatherAPIConfig) -> some View {
        let vm = SettingsViewModel(
            getPreferences: container.resolve(GetPreferencesUseCase.self),
            savePreferences: container.resolve(SavePreferencesUseCase.self),
            store: container.resolve(PreferencesStore.self),
            router: router,
            apiConfig: apiConfig
        )
        return SettingsView(viewModel: vm)
    }
}
