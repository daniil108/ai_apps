import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = "johndoe@example.com"
    @Published var password: String = "password"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let loginUseCase: LoginUseCase
    private weak var router: LoginRouter?

    init(loginUseCase: LoginUseCase, router: LoginRouter) {
        self.loginUseCase = loginUseCase
        self.router = router
    }

    func onLoginTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        Task {
            await authenticate()
        }
    }

    func onRegisterTapped() {
        router?.navigateToRegister()
    }

    func onForgotPasswordTapped() {
        router?.navigateToForgotPassword()
    }

    private func authenticate() async {
        isLoading = true
        errorMessage = nil
        do {
            let user = try await loginUseCase.execute(email: email, password: password)
            router?.loginSucceeded(user: user)
        } catch {
            errorMessage = "Invalid credentials"
        }
        isLoading = false
    }
}
