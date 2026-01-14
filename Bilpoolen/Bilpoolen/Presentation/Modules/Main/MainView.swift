import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    let newBookingView: AnyView
    let myBookingsView: AnyView
    let settingsView: AnyView

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
                    .init(title: "New Search", systemImage: "magnifyingglass"),
                    .init(title: "My Bookings", systemImage: "car.fill"),
                    .init(title: "Settings", systemImage: "gearshape.fill")
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
