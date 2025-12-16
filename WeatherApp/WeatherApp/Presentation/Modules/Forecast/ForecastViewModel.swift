import SwiftUI
import Combine

struct ForecastDay: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let entries: [ForecastEntry]
}

@MainActor
final class ForecastViewModel: ObservableObject {
    enum State {
        case loading
        case empty
        case loaded([ForecastDay], Units)
        case error(String)
    }

    @Published var state: State = .loading
    private let getForecast: GetForecastUseCase
    private let getPreferences: GetPreferencesUseCase
    private let getLastLocation: GetLastSelectedLocationUseCase
    private weak var router: ForecastRouting?

    init(getForecast: GetForecastUseCase, getPreferences: GetPreferencesUseCase, getLastLocation: GetLastSelectedLocationUseCase, router: ForecastRouting) {
        self.getForecast = getForecast
        self.getPreferences = getPreferences
        self.getLastLocation = getLastLocation
        self.router = router
    }

    func onAppear() {
        Task { await load() }
    }

    func refresh() {
        Task { await load() }
    }

    func backTapped() { router?.dismiss() }

    private func load() async {
        state = .loading
        do {
            guard let location = try await getLastLocation.execute() else {
                state = .empty
                return
            }
            let prefs = try await getPreferences.execute()
            let lang = prefs.useDeviceLanguage ? Locale.current.language.languageCode?.identifier : prefs.customLanguageCode
            let entries = try await getForecast.execute(location: location, units: prefs.units, language: lang)
            let grouped = group(entries: entries)
            state = .loaded(grouped, prefs.units)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    private func group(entries: [ForecastEntry]) -> [ForecastDay] {
        guard let offset = entries.first?.timezoneOffset else { return [] }
        let tz = TimeZone(secondsFromGMT: offset) ?? .current
        let calendar = Calendar(identifier: .gregorian)
        let grouped = Dictionary(grouping: entries) { entry in
            calendar.startOfDay(for: entry.timestamp, in: tz)
        }
        return grouped.keys.sorted().map { date in
            ForecastDay(date: date, entries: grouped[date] ?? [])
        }
    }
}

private extension Calendar {
    func startOfDay(for date: Date, in timeZone: TimeZone) -> Date {
        var calendar = self
        calendar.timeZone = timeZone
        return calendar.startOfDay(for: date)
    }
}
