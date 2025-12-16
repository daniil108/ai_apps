import SwiftUI

enum NewMeasurementModuleBuilder {
    static func build(container: DependencyContainer, router: NewMeasurementRouter) -> some View {
        let viewModel = NewMeasurementViewModel(
            startMeasurementUseCase: container.resolve(StartMeasurementUseCase.self),
            saveMeasurementUseCase: container.resolve(SaveMeasurementUseCase.self),
            router: router
        )
        return NewMeasurementView(viewModel: viewModel)
    }
}
