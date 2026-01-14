import SwiftUI

struct CarDetailsModuleBuilder {
    let container: AppContainer

    func build(car: Car, router: NewBookingRouting) -> some View {
        CarDetailsView(car: car)
    }
}
