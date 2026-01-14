import SwiftUI

struct MainModuleBuilder {
    let container: AppContainer

    func build(router: RootRouter, viewModel: MainViewModel) -> some View {
        let newBooking = AnyView(NewBookingModuleBuilder(container: container).build(router: router))
        let myBookings = AnyView(MyBookingsModuleBuilder(container: container).build(router: router))
        let settings = AnyView(SettingsModuleBuilder(container: container).build(router: router))
        return MainView(viewModel: viewModel, newBookingView: newBooking, myBookingsView: myBookings, settingsView: settings)
    }
}
