import SwiftUI

struct UnlockCarModuleBuilder {
    let container: AppContainer

    func build(booking: Booking, router: NewBookingRouting) -> some View {
        let viewModel = UnlockCarViewModel(booking: booking, router: router)
        return UnlockCarView(viewModel: viewModel)
    }
}
