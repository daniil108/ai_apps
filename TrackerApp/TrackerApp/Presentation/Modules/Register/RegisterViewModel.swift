import Foundation
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email: String = "johndoe@example.com"
    @Published var password: String = "password"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let registerUseCase: RegisterUseCase
    private weak var router: RegisterRouter?

    init(registerUseCase: RegisterUseCase, router: RegisterRouter) {
        self.registerUseCase = registerUseCase
        self.router = router
    }

    func onRegisterTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill all fields"
            return
        }
        Task { await register() }
    }

    func onBack() {
        router?.close()
    }

    private func register() async {
        isLoading = true
        errorMessage = nil
        do {
            let user = try await registerUseCase.execute(email: email, password: password)
            router?.registrationSucceeded(user: user)
        } catch {
            errorMessage = "Registration failed"
        }
        isLoading = false
    }
}
