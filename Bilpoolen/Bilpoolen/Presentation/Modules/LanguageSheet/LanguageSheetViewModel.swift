import Foundation
import Combine

@MainActor
final class LanguageSheetViewModel: ObservableObject {
    @Published var selectedLanguage: String = "System (English)"

    private let router: SettingsRouting

    init(router: SettingsRouting) {
        self.router = router
    }

    func languageTapped(_ language: String) {
        selectedLanguage = language
        router.dismissSheet()
    }
}
