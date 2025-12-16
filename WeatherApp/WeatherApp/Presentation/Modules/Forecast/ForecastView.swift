import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel: ForecastViewModel

    var body: some View {
        VStack {
            header
            content
        }
        .padding()
        .onAppear { viewModel.onAppear() }
        .background(GradientFactory.background(for: "forecast").ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        HStack {
            Button(action: { viewModel.backTapped() }) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            Spacer()
            Text("Forecast")
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
                .padding()
            Spacer()
        case .error(let message):
            Text(message)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        case .loaded(let days, let units):
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(days) { day in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(dayTitle(date: day.date))
                                .font(.headline)
                                .foregroundStyle(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(day.entries) { entry in
                                        forecastCard(entry: entry, units: units)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
        }
    }

    private func forecastCard(entry: ForecastEntry, units: Units) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(timeString(entry.timestamp, offset: entry.timezoneOffset))
                .font(.caption)
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(entry.iconId)@2x.png")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.white.opacity(0.1)
            }
            .frame(width: 50, height: 50)
            Text(String(format: "%.0f%@", entry.temp, units.temperatureSuffix))
                .font(.headline)
            Text(entry.description.capitalized)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
            Text("POP \(entry.popPercent)%")
                .font(.caption2)
            Text(String(format: "Wind %.1f", entry.windSpeed))
                .font(.caption2)
        }
        .padding()
        .frame(width: 150, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }

    private func dayTitle(date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) { return "Today" }
        if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    private func timeString(_ date: Date, offset: Int) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: offset)
        return formatter.string(from: date)
    }
}
