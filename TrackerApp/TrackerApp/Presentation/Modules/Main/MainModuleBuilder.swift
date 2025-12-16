import SwiftUI

enum MainModuleBuilder {
    static func build(container: DependencyContainer, router: MainRouter) -> some View {
        let viewModel = MainViewModel(
            pairDeviceUseCase: container.resolve(PairDeviceUseCase.self),
            getMeasurementsUseCase: container.resolve(GetMeasurementsUseCase.self),
            deviceRepository: container.resolve(DeviceRepository.self),
            router: router
        )
        if let appRouter = router as? AppRouter {
            return MainView(viewModel: viewModel, userEmail: appRouter.userEmail)
        } else {
            return MainView(viewModel: viewModel, userEmail: "")
        }
    }
}
