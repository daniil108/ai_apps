import Foundation

struct AppEnvironment {
    static func bootstrap() -> AppRouter {
        let container = DIContainer()
        let apiConfig = DefaultWeatherAPIConfig()
        container.register(WeatherAPIConfig.self) { _ in apiConfig }
        container.register(NetworkLogger.self) { _ in DefaultNetworkLogger() }
        container.register(RequestBuilding.self) { c in RequestBuilder(apiConfig: c.resolve(WeatherAPIConfig.self)) }
        container.register(HTTPClient.self) { c in URLSessionHTTPClient(logger: c.resolve(NetworkLogger.self)) }
        container.register(PreferencesStore.self) { _ in UserDefaultsPreferencesStore() }

        container.register(GeocodingRepository.self) { c in
            GeocodingRepositoryImpl(client: c.resolve(HTTPClient.self), builder: c.resolve(RequestBuilding.self), config: c.resolve(WeatherAPIConfig.self))
        }
        container.register(WeatherRepository.self) { c in
            WeatherRepositoryImpl(client: c.resolve(HTTPClient.self), builder: c.resolve(RequestBuilding.self), config: c.resolve(WeatherAPIConfig.self), preferencesStore: c.resolve(PreferencesStore.self))
        }
        container.register(AirQualityRepository.self) { c in
            AirQualityRepositoryImpl(client: c.resolve(HTTPClient.self), builder: c.resolve(RequestBuilding.self), config: c.resolve(WeatherAPIConfig.self), preferencesStore: c.resolve(PreferencesStore.self))
        }

        container.register(GetPreferencesUseCase.self) { c in GetPreferencesUseCase(store: c.resolve(PreferencesStore.self)) }
        container.register(SavePreferencesUseCase.self) { c in SavePreferencesUseCase(store: c.resolve(PreferencesStore.self)) }
        container.register(GetLastSelectedLocationUseCase.self) { c in GetLastSelectedLocationUseCase(store: c.resolve(PreferencesStore.self)) }
        container.register(SaveLastSelectedLocationUseCase.self) { c in SaveLastSelectedLocationUseCase(store: c.resolve(PreferencesStore.self)) }
        container.register(SearchLocationsUseCase.self) { c in SearchLocationsUseCase(repository: c.resolve(GeocodingRepository.self)) }
        container.register(GetCurrentWeatherUseCase.self) { c in GetCurrentWeatherUseCase(repository: c.resolve(WeatherRepository.self)) }
        container.register(GetForecastUseCase.self) { c in GetForecastUseCase(repository: c.resolve(WeatherRepository.self)) }
        container.register(GetAirQualityUseCase.self) { c in GetAirQualityUseCase(repository: c.resolve(AirQualityRepository.self)) }

        return AppRouter(container: container, apiConfig: apiConfig)
    }
}
