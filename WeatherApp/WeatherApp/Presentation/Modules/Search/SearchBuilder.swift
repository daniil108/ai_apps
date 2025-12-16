import SwiftUI

enum SearchBuilder {
    static func build(container: DIContainer, router: SearchRouting) -> some View {
        let vm = SearchViewModel(
            searchUseCase: container.resolve(SearchLocationsUseCase.self),
            saveLastLocation: container.resolve(SaveLastSelectedLocationUseCase.self),
            router: router
        )
        return SearchView(viewModel: vm)
    }
}
