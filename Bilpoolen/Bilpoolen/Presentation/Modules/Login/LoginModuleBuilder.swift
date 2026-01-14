import SwiftUI

struct LoginModuleBuilder {
    let container: AppContainer

    func build(router: LoginRouting) -> some View {
        let viewModel = LoginViewModel(loginUseCase: container.makeLoginUseCase(), router: router)
        return LoginView(viewModel: viewModel)
    }
}
