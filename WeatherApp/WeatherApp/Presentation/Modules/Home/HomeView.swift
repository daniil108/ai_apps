import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        content
            .onAppear { viewModel.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            gradientBackground(condition: "").overlay(onboarding)
        case .loading:
            gradientBackground(condition: "").overlay(loadingView)
        case .loaded(let weather, let units):
            gradientBackground(condition: weather.conditionMain).overlay(loadedView(weather: weather, units: units))
        case .error(let message):
            gradientBackground(condition: "").overlay(errorView(message: message))
        }
    }

    private func gradientBackground(condition: String) -> some View {
        GradientFactory.background(for: condition)
            .ignoresSafeArea()
    }

    private var onboarding: some View {
        VStack(spacing: 16) {
            Text("Welcome")
                .font(.largeTitle.bold())
            Text("Select a city to get started.")
            PrimaryButton(title: "Search") { viewModel.searchTapped() }
        }
        .padding()
    }

    private var loadingView: some View {
        ScrollView {
            VStack(spacing: 16) {
                topBar(title: "Loading…")
                heroCard(temp: "--", description: "Loading")
                    .redacted(reason: .placeholder)
                infoGrid(weather: nil, units: .metric)
                    .redacted(reason: .placeholder)
            }
            .padding()
        }
    }

    private func loadedView(weather: CurrentWeather, units: Units) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                topBar(title: viewModel.locationName)
                heroCard(temp: String(format: "%.0f%@", weather.temperature, units.temperatureSuffix), description: weather.conditionDescription, icon: weather.iconId)
                infoGrid(weather: weather, units: units)
                sunriseSunset(weather: weather)
                actionRow
            }
            .padding()
        }
        .refreshable { viewModel.refresh() }
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text("Something went wrong")
                .font(.title2.bold())
            Text(message)
                .multilineTextAlignment(.center)
            PrimaryButton(title: "Retry") { viewModel.refresh() }
        }
        .padding()
    }

    private func topBar(title: String) -> some View {
        HStack {
            Button(action: { viewModel.searchTapped() }) {
                HStack {
                    Image(systemName: "location.fill")
                    Text(title)
                        .font(.title3.bold())
                        .lineLimit(1)
                }
            }
            Spacer()
            Button(action: { viewModel.settingsTapped() }) {
                Image(systemName: "gearshape.fill")
                    .frame(width: 44, height: 44)
            }
        }
        .foregroundStyle(.white)
    }

    private func heroCard(temp: String, description: String, icon: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(temp)
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(.white)
                    Text(description.capitalized)
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.9))
                }
                Spacer()
                if let icon {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 72, height: 72)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func infoGrid(weather: CurrentWeather?, units: Units) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            infoCell(title: "Feels like", value: weather != nil ? String(format: "%.0f%@", weather!.feelsLike, units.temperatureSuffix) : "--")
            infoCell(title: "Humidity", value: weather != nil ? "\(weather!.humidity)%" : "--")
            infoCell(title: "Pressure", value: weather != nil ? "\(weather!.pressure) hPa" : "--")
            infoCell(title: "Wind", value: weather != nil ? String(format: "%.1f m/s %@", weather!.windSpeed, compass(degrees: weather!.windDegree)) : "--")
            infoCell(title: "Clouds", value: weather != nil ? "\(weather!.cloudiness)%" : "--")
            if let rain = weather?.rainLastHour {
                infoCell(title: "Rain", value: "\(rain) mm")
            }
            if let snow = weather?.snowLastHour {
                infoCell(title: "Snow", value: "\(snow) mm")
            }
        }
    }

    private func sunriseSunset(weather: CurrentWeather) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Sunrise")
                Text(timeString(from: weather.sunrise, offset: weather.timezoneOffset))
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Sunset")
                Text(timeString(from: weather.sunset, offset: weather.timezoneOffset))
                    .font(.headline)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var actionRow: some View {
        HStack(spacing: 12) {
            PrimaryButton(title: "Forecast") { viewModel.forecastTapped() }
            PrimaryButton(title: "Air Quality") { viewModel.airQualityTapped() }
            PrimaryButton(title: "Refresh") { viewModel.refresh() }
        }
    }

    private func infoCell(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
            Text(value)
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func timeString(from date: Date, offset: Int) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: offset)
        return formatter.string(from: date)
    }

    private func compass(degrees: Double) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
        let index = Int((degrees + 22.5) / 45.0)
        return directions[index % directions.count]
    }
}
