import Foundation
import Combine

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = "johndoe@example.com"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let restorePasswordUseCase: RestorePasswordUseCase
    private weak var router: ForgotPasswordRouter?

    init(restorePasswordUseCase: RestorePasswordUseCase, router: ForgotPasswordRouter) {
        self.restorePasswordUseCase = restorePasswordUseCase
        self.router = router
    }

    func onBack() {
        router?.passwordRestored()
    }

    func onRestoreTapped() {
        guard !email.isEmpty else {
            errorMessage = "Email required"
            return
        }
        Task { await restore() }
    }

    private func restore() async {
        isLoading = true
        errorMessage = nil
        do {
            try await restorePasswordUseCase.execute(email: email)
            router?.passwordRestored()
        } catch {
            errorMessage = "Try again later"
        }
        isLoading = false
    }
}
