import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    let userEmail: String

    init(viewModel: MainViewModel, userEmail: String) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.userEmail = userEmail
    }

    private var descriptionText: String {
        switch viewModel.connectionState {
        case .notConnected:
            return "To start a measurement,\npease pair with the device"
        case .connected:
            return "To start a measurement,\npease click start new measurement button"
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                statusSection
                    .frame(maxWidth: .infinity, alignment: .center)
                PrimaryButton(
                    title: viewModel.connectionState == .connected ? "Start new measurement" : "Pair with device",
                    action: primaryAction,
                    leadingSystemImage: viewModel.connectionState == .connected ? "ruler" : "bolt.horizontal",
                    isLoading: viewModel.isLoading
                )
                Section(header: previousMeasurementsHeader) {
                    measurementsList
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            .padding(.top, 12)
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear { viewModel.onAppear() }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("header_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 26)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.onShowSettings() }) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Theme.text)
                }
            }
        }
    }

    private var statusSection: some View {
        VStack(spacing: 8) {
            Text(viewModel.connectionState == .connected ? "Device is connected" : "Device is not connected")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Theme.text)
                .multilineTextAlignment(.center)
            Text(descriptionText)
                .font(.system(size: 15))
                .foregroundColor(Theme.mutedText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }

    private var previousMeasurementsHeader: some View {
        Text("Previous measurements")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Theme.text)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
    }

    private var measurementsList: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.measurements) { measurement in
                Button(action: { viewModel.onSelectMeasurement(measurement) }) {
                    MeasurementRowView(measurement: measurement)
                        .contentShape(Rectangle())
                }
            }
        }
    }

    private func primaryAction() {
        switch viewModel.connectionState {
        case .notConnected:
            viewModel.onPairTapped()
        case .connected:
            viewModel.onNewMeasurement()
        }
    }
}
