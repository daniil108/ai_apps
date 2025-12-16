import SwiftUI

enum HomeBuilder {
    static func build(container: DIContainer, router: HomeRouting) -> some View {
        let vm = HomeViewModel(
            getCurrentWeather: container.resolve(GetCurrentWeatherUseCase.self),
            getPreferences: container.resolve(GetPreferencesUseCase.self),
            getLastLocation: container.resolve(GetLastSelectedLocationUseCase.self),
            router: router
        )
        return HomeView(viewModel: vm)
    }
}
