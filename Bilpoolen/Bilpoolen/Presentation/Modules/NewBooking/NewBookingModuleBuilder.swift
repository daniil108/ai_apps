import SwiftUI

struct NewBookingModuleBuilder {
    let container: AppContainer

    func build(router: NewBookingRouting) -> some View {
        let viewModel = NewBookingViewModel(
            fetchBookingsUseCase: container.makeFetchBookingsUseCase(),
            fetchAvailableCarsUseCase: container.makeFetchAvailableCarsUseCase(),
            router: router
        )
        return NewBookingView(viewModel: viewModel)
    }
}
