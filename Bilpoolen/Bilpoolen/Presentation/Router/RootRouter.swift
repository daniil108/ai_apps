import SwiftUI
import Combine

@MainActor
final class RootRouter: ObservableObject, LoginRouting, NewBookingRouting, MyBookingsRouting, SettingsRouting {
    enum Root {
        case login
        case main
    }

    enum Route: Hashable {
        case filters
        case map
        case carDetails(Car)
        case unlockCar(Booking)
        case lockCar(Booking)
        case upcomingBooking(Booking)
        case settingsStartingLocation
        case settingsStartingLocationNew
        case settingsCostCenters
        case settingsPastBookings
        case settingsMyInfo
        case settingsCompanyInfo
        case settingsCustomerService
    }

    enum Sheet: Identifiable {
        case language

        var id: String {
            switch self {
            case .language:
                return "language"
            }
        }
    }

    enum Modal: Identifiable {
        case filters
        case carDetails(Car)
        case unlockCar(Booking)
        case lockCar(Booking)
        case upcomingBooking(Booking)

        var id: String {
            switch self {
            case .filters:
                return "filters"
            case .carDetails(let car):
                return "carDetails-\(car.id.uuidString)"
            case .unlockCar(let booking):
                return "unlockCar-\(booking.id.uuidString)"
            case .lockCar(let booking):
                return "lockCar-\(booking.id.uuidString)"
            case .upcomingBooking(let booking):
                return "upcomingBooking-\(booking.id.uuidString)"
            }
        }
    }

    @Published var root: Root = .login
    @Published var path = NavigationPath()
    @Published var activeSheet: Sheet?
    @Published var activeModal: Modal?

    let container: AppContainer
    private let mainViewModel = MainViewModel()

    init(container: AppContainer) {
        self.container = container
    }

    func rootView() -> AnyView {
        switch root {
        case .login:
            return AnyView(LoginModuleBuilder(container: container).build(router: self))
        case .main:
            return AnyView(MainModuleBuilder(container: container).build(router: self, viewModel: mainViewModel))
        }
    }

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .filters:
            FiltersModuleBuilder(container: container).build()
        case .map:
            MapModuleBuilder(container: container).build(router: self)
        case .carDetails(let car):
            CarDetailsModuleBuilder(container: container).build(car: car, router: self)
        case .unlockCar(let booking):
            UnlockCarModuleBuilder(container: container).build(booking: booking, router: self)
        case .lockCar(let booking):
            LockCarModuleBuilder(container: container).build(booking: booking)
        case .upcomingBooking(let booking):
            UpcomingBookingModuleBuilder(container: container).build(booking: booking)
        case .settingsStartingLocation:
            StartingLocationModuleBuilder(container: container).build(router: self)
        case .settingsStartingLocationNew:
            StartingLocationNewModuleBuilder(container: container).build()
        case .settingsCostCenters:
            CostCentersModuleBuilder(container: container).build()
        case .settingsPastBookings:
            PastBookingsModuleBuilder(container: container).build()
        case .settingsMyInfo:
            MyInfoModuleBuilder(container: container).build()
        case .settingsCompanyInfo:
            CompanyInfoModuleBuilder(container: container).build()
        case .settingsCustomerService:
            CustomerServiceModuleBuilder(container: container).build()
        }
    }

    @ViewBuilder
    func sheetView(for sheet: Sheet) -> some View {
        switch sheet {
        case .language:
            LanguageSheetModuleBuilder(container: container).build(router: self)
        }
    }

    @ViewBuilder
    func modalView(for modal: Modal) -> some View {
        switch modal {
        case .filters:
            FiltersModuleBuilder(container: container).build()
        case .carDetails(let car):
            CarDetailsModuleBuilder(container: container).build(car: car, router: self)
        case .unlockCar(let booking):
            UnlockCarModuleBuilder(container: container).build(booking: booking, router: self)
        case .lockCar(let booking):
            LockCarModuleBuilder(container: container).build(booking: booking)
        case .upcomingBooking(let booking):
            UpcomingBookingModuleBuilder(container: container).build(booking: booking)
        }
    }

    func showFilters() {
        activeModal = .filters
    }

    func showMap() {
        path.append(Route.map)
    }

    func showCarDetails(car: Car) {
        activeModal = .carDetails(car)
    }

    func showUnlockCar(booking: Booking) {
        activeModal = .unlockCar(booking)
    }

    func showLockCar(booking: Booking) {
        activeModal = .lockCar(booking)
    }

    func showUpcomingBooking(booking: Booking) {
        activeModal = .upcomingBooking(booking)
    }

    func showLanguageSheet() {
        activeSheet = .language
    }

    func showStartingLocation() {
        path.append(Route.settingsStartingLocation)
    }

    func showStartingLocationNew() {
        path.append(Route.settingsStartingLocationNew)
    }

    func showCostCenters() {
        path.append(Route.settingsCostCenters)
    }

    func showPastBookings() {
        path.append(Route.settingsPastBookings)
    }

    func showMyInfo() {
        path.append(Route.settingsMyInfo)
    }

    func showCompanyInfo() {
        path.append(Route.settingsCompanyInfo)
    }

    func showCustomerService() {
        path.append(Route.settingsCustomerService)
    }

    func dismissSheet() {
        activeSheet = nil
    }

    func didLogin() {
        path.removeLast(path.count)
        root = .main
    }

    func logout() {
        path.removeLast(path.count)
        root = .login
    }
}
