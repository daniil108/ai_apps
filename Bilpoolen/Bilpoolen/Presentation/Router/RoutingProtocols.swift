import Foundation

protocol LoginRouting {
    func didLogin()
}

protocol NewBookingRouting {
    func showFilters()
    func showMap()
    func showCarDetails(car: Car)
    func showUnlockCar(booking: Booking)
    func showLockCar(booking: Booking)
}

protocol MyBookingsRouting {
    func showUnlockCar(booking: Booking)
    func showUpcomingBooking(booking: Booking)
}

protocol SettingsRouting {
    func showLanguageSheet()
    func showStartingLocation()
    func showStartingLocationNew()
    func showCostCenters()
    func showPastBookings()
    func showMyInfo()
    func showCompanyInfo()
    func showCustomerService()
    func logout()
    func dismissSheet()
}
