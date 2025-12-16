import SwiftUI

struct AirQualityView: View {
    @ObservedObject var viewModel: AirQualityViewModel

    var body: some View {
        VStack(spacing: 12) {
            header
            content
        }
        .padding()
        .background(GradientFactory.background(for: "air").ignoresSafeArea())
        .onAppear { viewModel.onAppear() }
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        HStack {
            Button(action: { viewModel.backTapped() }) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            Spacer()
            Text("Air Quality")
                .font(.title2.bold())
            Spacer()
            Button(action: { viewModel.refresh() }) {
                Image(systemName: "arrow.clockwise")
                    .frame(width: 44, height: 44)
            }
        }
        .foregroundStyle(.white)
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView().tint(.white)
            Spacer()
        case .empty:
            Text("Select a city from Home")
                .foregroundColor(.white)
            Spacer()
        case .error(let message):
            Text(message)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        case .loaded(let aq, let location):
            ScrollView {
                VStack(spacing: 16) {
                    hero(aq: aq, location: location)
                    pollutants(aq: aq)
                }
            }
        }
    }

    private func hero(aq: AirQuality, location: Location) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.headline)
            Text("AQI \(aq.aqi)")
                .font(.system(size: 48, weight: .bold))
            Text(aqiLabel(aq.aqi))
                .font(.title3)
            Text("Updated \(DateFormatter.localizedString(from: aq.timestamp, dateStyle: .short, timeStyle: .short))")
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(.white)
    }

    private func pollutants(aq: AirQuality) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pollutants").font(.headline)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                pollutant(name: "PM2.5", value: aq.pm2_5)
                pollutant(name: "PM10", value: aq.pm10)
                pollutant(name: "O3", value: aq.o3)
                pollutant(name: "NO2", value: aq.no2)
                pollutant(name: "CO", value: aq.co)
                pollutant(name: "SO2", value: aq.so2)
                pollutant(name: "NH3", value: aq.nh3)
                pollutant(name: "NO", value: aq.no)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(.white)
    }

    private func pollutant(name: String, value: Double) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.caption)
            Text(String(format: "%.1f µg/m³", value))
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func aqiLabel(_ value: Int) -> String {
        switch value {
        case 1: return "Good"
        case 2: return "Fair"
        case 3: return "Moderate"
        case 4: return "Poor"
        default: return "Very Poor"
        }
    }
}
