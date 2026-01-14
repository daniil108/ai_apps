import SwiftUI

struct MapModuleBuilder {
    let container: AppContainer

    func build(router: NewBookingRouting) -> some View {
        let viewModel = MapViewModel(fetchAvailableCarsUseCase: container.makeFetchAvailableCarsUseCase(), router: router)
        return MapView(viewModel: viewModel)
    }
}
