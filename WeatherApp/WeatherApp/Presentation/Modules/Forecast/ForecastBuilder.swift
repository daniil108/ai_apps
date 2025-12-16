import SwiftUI

enum ForecastBuilder {
    static func build(container: DIContainer, router: ForecastRouting) -> some View {
        let vm = ForecastViewModel(
            getForecast: container.resolve(GetForecastUseCase.self),
            getPreferences: container.resolve(GetPreferencesUseCase.self),
            getLastLocation: container.resolve(GetLastSelectedLocationUseCase.self),
            router: router
        )
        return ForecastView(viewModel: vm)
    }
}
