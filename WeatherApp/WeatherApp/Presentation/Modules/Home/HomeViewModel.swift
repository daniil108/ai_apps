import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded(CurrentWeather, Units)
        case error(String)
    }

    @Published var state: State = .idle
    @Published var locationName: String = "Select a city"

    private let getCurrentWeather: GetCurrentWeatherUseCase
    private let getPreferences: GetPreferencesUseCase
    private let getLastLocation: GetLastSelectedLocationUseCase
    private weak var router: HomeRouting?
    private var units: Units = .metric
    private var currentLocation: Location?

    init(getCurrentWeather: GetCurrentWeatherUseCase, getPreferences: GetPreferencesUseCase, getLastLocation: GetLastSelectedLocationUseCase, router: HomeRouting) {
        self.getCurrentWeather = getCurrentWeather
        self.getPreferences = getPreferences
        self.getLastLocation = getLastLocation
        self.router = router
    }

    func onAppear() {
        Task { await loadInitial() }
    }

    func searchTapped() { router?.showSearch() }
    func settingsTapped() { router?.showSettings() }
    func forecastTapped() { router?.showForecast() }
    func airQualityTapped() { router?.showAirQuality() }

    func refresh() {
        guard let location = currentLocation else { return }
        Task { await fetchWeather(for: location) }
    }

    private func loadInitial() async {
        state = .loading
        do {
            let prefs = try await getPreferences.execute()
            units = prefs.units
            currentLocation = try await getLastLocation.execute()
            if let location = currentLocation {
                locationName = location.name
                await fetchWeather(for: location)
            } else {
                state = .idle
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    private func fetchWeather(for location: Location) async {
        state = .loading
        do {
            let prefs = try await getPreferences.execute()
            units = prefs.units
            let lang = prefs.useDeviceLanguage ? Locale.current.language.languageCode?.identifier : prefs.customLanguageCode
            let weather = try await getCurrentWeather.execute(location: location, units: prefs.units, language: lang)
            locationName = weather.locationName
            state = .loaded(weather, prefs.units)
        } catch let error as DomainError {
            state = .error(error.localizedDescription)
        } catch let error as NetworkError {
            state = .error(error.localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
