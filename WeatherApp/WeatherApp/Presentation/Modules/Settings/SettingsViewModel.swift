import SwiftUI
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var preferences: Preferences = .default
    @Published var apiKeyWarning: String?

    private let getPreferences: GetPreferencesUseCase
    private let savePreferences: SavePreferencesUseCase
    private let store: PreferencesStore
    private weak var router: SettingsRouting?
    private let apiConfig: WeatherAPIConfig

    init(getPreferences: GetPreferencesUseCase, savePreferences: SavePreferencesUseCase, store: PreferencesStore, router: SettingsRouting, apiConfig: WeatherAPIConfig) {
        self.getPreferences = getPreferences
        self.savePreferences = savePreferences
        self.store = store
        self.router = router
        self.apiConfig = apiConfig
        if apiConfig.apiKey.isEmpty { apiKeyWarning = "API key is missing. Add your OpenWeather key in DefaultWeatherAPIConfig." }
    }

    func onAppear() {
        Task {
            preferences = (try? await getPreferences.execute()) ?? .default
        }
    }

    func setUnits(_ units: Units) {
        preferences.units = units
        save()
    }

    func toggleDeviceLanguage(_ value: Bool) {
        preferences.useDeviceLanguage = value
        if value { preferences.customLanguageCode = nil }
        save()
    }

    func updateLanguage(_ code: String) {
        preferences.customLanguageCode = code
        preferences.useDeviceLanguage = false
        save()
    }

    func toggleCache(_ value: Bool) {
        preferences.cacheResponses = value
        save()
    }

    func clearCache() {
        store.clearCache()
    }

    func back() { router?.dismiss() }

    private func save() {
        Task { try? await savePreferences.execute(preferences) }
    }
}
