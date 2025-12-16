import SwiftUI

enum ForgotPasswordModuleBuilder {
    static func build(container: DependencyContainer, router: ForgotPasswordRouter) -> some View {
        let viewModel = ForgotPasswordViewModel(
            restorePasswordUseCase: container.resolve(RestorePasswordUseCase.self),
            router: router
        )
        return ForgotPasswordView(viewModel: viewModel)
    }
}
