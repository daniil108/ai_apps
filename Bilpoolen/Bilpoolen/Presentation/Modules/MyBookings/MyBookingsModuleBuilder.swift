import SwiftUI

struct MyBookingsModuleBuilder {
    let container: AppContainer

    func build(router: MyBookingsRouting) -> some View {
        let viewModel = MyBookingsViewModel(fetchBookingsUseCase: container.makeFetchBookingsUseCase(), router: router)
        return MyBookingsView(viewModel: viewModel)
    }
}
