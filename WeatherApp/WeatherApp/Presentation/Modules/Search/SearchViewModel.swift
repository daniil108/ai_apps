import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = "" { didSet { queryChanged() } }
    @Published var results: [Location] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let searchUseCase: SearchLocationsUseCase
    private let saveLastLocation: SaveLastSelectedLocationUseCase
    private weak var router: SearchRouting?
    private var debounceTask: Task<Void, Never>?

    init(searchUseCase: SearchLocationsUseCase, saveLastLocation: SaveLastSelectedLocationUseCase, router: SearchRouting) {
        self.searchUseCase = searchUseCase
        self.saveLastLocation = saveLastLocation
        self.router = router
    }

    func onAppear() {}

    private func queryChanged() {
        debounceTask?.cancel()
        guard !query.isEmpty else {
            results = []
            return
        }
        debounceTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 400_000_000)
            await self?.performSearch()
        }
    }

    private func performSearch() async {
        isLoading = true
        errorMessage = nil
        do {
            let items = try await searchUseCase.execute(query: query)
            results = items
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func select(location: Location) {
        Task {
            try? await saveLastLocation.execute(location)
            router?.dismiss()
        }
    }

    func backTapped() { router?.dismiss() }
}
