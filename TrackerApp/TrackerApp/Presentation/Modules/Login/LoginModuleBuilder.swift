import SwiftUI

enum LoginModuleBuilder {
    static func build(container: DependencyContainer, router: LoginRouter) -> some View {
        let viewModel = LoginViewModel(
            loginUseCase: container.resolve(LoginUseCase.self),
            router: router
        )
        return LoginView(viewModel: viewModel)
    }
}
