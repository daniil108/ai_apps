import SwiftUI

struct CustomerServiceModuleBuilder {
    let container: AppContainer

    func build() -> some View {
        CustomerServiceView()
    }
}
