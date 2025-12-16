import SwiftUI
import Combine

enum RootScreen {
    case loading
    case login
    case main
}

enum AppRoute: Hashable {
    case register
    case forgotPassword
    case newMeasurement
    case savedMeasurement(Measurement)
}

protocol LoginRouter: AnyObject {
    func navigateToRegister()
    func navigateToForgotPassword()
    func loginSucceeded(user: User)
}

protocol RegisterRouter: AnyObject {
    func registrationSucceeded(user: User)
    func close()
}

protocol ForgotPasswordRouter: AnyObject {
    func passwordRestored()
}

protocol MainRouter: AnyObject {
    func startNewMeasurement()
    func openMeasurement(_ measurement: Measurement)
    func showSettings()
    func logout()
}

protocol NewMeasurementRouter: AnyObject {
    func closeAfterSave()
}

protocol SavedMeasurementRouter: AnyObject {
    func closeSavedMeasurement()
}

protocol SettingsRouter: AnyObject {
    func dismissSettings()
    func logout()
}

final class AppRouter: ObservableObject {
    @Published var rootScreen: RootScreen = .loading
    @Published var path: [AppRoute] = []
    @Published var isSettingsVisible: Bool = false
    @Published var userEmail: String = ""

    let container: DependencyContainer
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    private let logoutUseCase: LogoutUseCase

    init(container: DependencyContainer) {
        self.container = container
        self.getCurrentUserUseCase = container.resolve(GetCurrentUserUseCase.self)
        self.logoutUseCase = container.resolve(LogoutUseCase.self)
    }

    func start() {
        Task { @MainActor in
            let user = await getCurrentUserUseCase.execute()
            userEmail = user?.email ?? ""
            rootScreen = user == nil ? .login : .main
        }
    }
}

extension AppRouter: LoginRouter {
    func navigateToRegister() {
        path.append(.register)
    }

    func navigateToForgotPassword() {
        path.append(.forgotPassword)
    }

    func loginSucceeded(user: User) {
        path = []
        rootScreen = .main
        userEmail = user.email
    }
}

extension AppRouter: RegisterRouter {
    func registrationSucceeded(user: User) {
        path = []
        rootScreen = .main
        userEmail = user.email
    }

    func close() {
        path.removeAll { route in
            if case .register = route { return true }
            return false
        }
    }
}

extension AppRouter: ForgotPasswordRouter {
    func passwordRestored() {
        path = []
        rootScreen = .login
    }
}

extension AppRouter: MainRouter {
    func startNewMeasurement() {
        path.append(.newMeasurement)
    }

    func openMeasurement(_ measurement: Measurement) {
        path.append(.savedMeasurement(measurement))
    }

    func showSettings() {
        isSettingsVisible = true
    }

    func logout() {
        Task { @MainActor in
            await logoutUseCase.execute()
            path = []
            rootScreen = .login
            isSettingsVisible = false
        }
    }
}

extension AppRouter: NewMeasurementRouter {
    func closeAfterSave() {
        path = []
    }
}

extension AppRouter: SavedMeasurementRouter {
    func closeSavedMeasurement() {
        _ = path.popLast()
    }
}

extension AppRouter: SettingsRouter {
    func dismissSettings() {
        isSettingsVisible = false
    }
}
