import Foundation
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    enum Tab: Int, CaseIterable {
        case newBooking
        case myBookings
        case settings
    }

    @Published var selectedTab: Tab = .newBooking
}
