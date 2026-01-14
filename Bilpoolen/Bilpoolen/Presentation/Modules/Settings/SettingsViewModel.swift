import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    private let router: SettingsRouting

    init(router: SettingsRouting) {
        self.router = router
    }

    func languageTapped() {
        router.showLanguageSheet()
    }

    func startingLocationTapped() {
        router.showStartingLocation()
    }

    func costCentersTapped() {
        router.showCostCenters()
    }

    func pastBookingsTapped() {
        router.showPastBookings()
    }

    func myInfoTapped() {
        router.showMyInfo()
    }

    func companyInfoTapped() {
        router.showCompanyInfo()
    }

    func customerServiceTapped() {
        router.showCustomerService()
    }

    func logoutTapped() {
        router.logout()
    }
}
