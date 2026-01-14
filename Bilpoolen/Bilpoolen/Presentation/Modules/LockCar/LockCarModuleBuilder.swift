import SwiftUI

struct LockCarModuleBuilder {
    let container: AppContainer

    func build(booking: Booking) -> some View {
        LockCarView(booking: booking)
    }
}
