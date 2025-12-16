import SwiftUI
import Combine

protocol HomeRouting: AnyObject {
    func showSearch()
    func showForecast()
    func showAirQuality()
    func showSettings()
}

protocol SearchRouting: AnyObject {
    func dismiss()
}

protocol ForecastRouting: AnyObject { func dismiss() }
protocol AirQualityRouting: AnyObject { func dismiss() }
protocol SettingsRouting: AnyObject { func dismiss() }

enum AppRoute: Hashable {
    case search
    case forecast
    case airQuality
    case settings
}

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    private let container: DIContainer
    private let apiConfig: WeatherAPIConfig

    init(container: DIContainer, apiConfig: WeatherAPIConfig) {
        self.container = container
        self.apiConfig = apiConfig
    }

    @ViewBuilder
    func rootView() -> some View {
        NavigationStack(path: Binding(get: { self.path }, set: { self.path = $0 })) {
            HomeBuilder.build(container: container, router: self)
                .navigationDestination(for: AppRoute.self) { route in
                    self.destination(for: route)
                }
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .search:
            SearchBuilder.build(container: container, router: self)
        case .forecast:
            ForecastBuilder.build(container: container, router: self)
        case .airQuality:
            AirQualityBuilder.build(container: container, router: self)
        case .settings:
            SettingsBuilder.build(container: container, router: self, apiConfig: apiConfig)
        }
    }
}

extension AppRouter: HomeRouting {
    func showSearch() { path.append(AppRoute.search) }
    func showForecast() { path.append(AppRoute.forecast) }
    func showAirQuality() { path.append(AppRoute.airQuality) }
    func showSettings() { path.append(AppRoute.settings) }
}

extension AppRouter: SearchRouting, ForecastRouting, AirQualityRouting, SettingsRouting {
    func dismiss() { path.removeLast() }
}
