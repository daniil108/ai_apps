import SwiftUI

enum AirQualityBuilder {
    static func build(container: DIContainer, router: AirQualityRouting) -> some View {
        let vm = AirQualityViewModel(
            getAirQuality: container.resolve(GetAirQualityUseCase.self),
            getLastLocation: container.resolve(GetLastSelectedLocationUseCase.self),
            router: router
        )
        return AirQualityView(viewModel: vm)
    }
}
