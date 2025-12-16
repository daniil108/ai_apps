import SwiftUI

enum SavedMeasurementModuleBuilder {
    static func build(container: DependencyContainer, router: SavedMeasurementRouter, measurement: Measurement) -> some View {
        let viewModel = SavedMeasurementViewModel(measurement: measurement, router: router)
        return SavedMeasurementView(viewModel: viewModel)
    }
}
