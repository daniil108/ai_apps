import SwiftUI

struct UpcomingBookingModuleBuilder {
    let container: AppContainer

    func build(booking: Booking) -> some View {
        UpcomingBookingView(booking: booking)
    }
}
