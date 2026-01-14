import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = "johndoe@example.com"
    @Published var password: String = "******"
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let loginUseCase: LoginUseCase
    private let router: LoginRouting

    init(loginUseCase: LoginUseCase, router: LoginRouting) {
        self.loginUseCase = loginUseCase
        self.router = router
    }

    func loginTapped() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                _ = try await loginUseCase.execute(email: email, password: password)
                isLoading = false
                router.didLogin()
            } catch {
                isLoading = false
                errorMessage = "Invalid credentials. Try again."
            }
        }
    }
}
