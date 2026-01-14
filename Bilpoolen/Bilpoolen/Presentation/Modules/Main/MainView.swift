import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    let newBookingView: AnyView
    let myBookingsView: AnyView
    let settingsView: AnyView

    init(viewModel: MainViewModel, newBookingView: AnyView, myBookingsView: AnyView, settingsView: AnyView) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.newBookingView = newBookingView
        self.myBookingsView = myBookingsView
        self.settingsView = settingsView
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch viewModel.selectedTab {
                case .newBooking:
                    newBookingView
                case .myBookings:
                    myBookingsView
                case .settings:
                    settingsView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            FloatingTabBar(
                items: [
                    .init(title: "New Search", imageName: "magnifyingglass", usesAsset: false),
                    .init(title: "My Bookings", imageName: "car.fill", usesAsset: false),
                    .init(title: "Settings", imageName: "gearshape.fill", usesAsset: false)
                ],
                selectedIndex: viewModel.selectedTab.rawValue,
                onSelect: { index in
                    if let tab = MainViewModel.Tab(rawValue: index) {
                        viewModel.selectedTab = tab
                    }
                }
            )
            .padding(.bottom, 18)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
    }
}
