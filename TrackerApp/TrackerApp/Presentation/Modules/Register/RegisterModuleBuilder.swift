import SwiftUI

enum RegisterModuleBuilder {
    static func build(container: DependencyContainer, router: RegisterRouter) -> some View {
        let viewModel = RegisterViewModel(
            registerUseCase: container.resolve(RegisterUseCase.self),
            router: router
        )
        return RegisterView(viewModel: viewModel)
    }
}
