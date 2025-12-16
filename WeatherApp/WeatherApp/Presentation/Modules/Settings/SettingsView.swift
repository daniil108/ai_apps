import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                if let warning = viewModel.apiKeyWarning {
                    Text(warning)
                        .foregroundColor(.yellow)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                unitsSection
                languageSection
                cacheSection
                aboutSection
            }
            .padding()
        }
        .background(GradientFactory.background(for: "settings").ignoresSafeArea())
        .onAppear { viewModel.onAppear() }
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        HStack {
            Button(action: { viewModel.back() }) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            Spacer()
            Text("Settings")
                .font(.title2.bold())
            Spacer()
            Spacer().frame(width: 44)
        }
        .foregroundStyle(.white)
    }

    private var unitsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Units").font(.headline)
            HStack(spacing: 8) {
                ForEach(Units.allCases, id: \.self) { unit in
                    MetricChip(title: unit.displayName, isSelected: viewModel.preferences.units == unit) {
                        viewModel.setUnits(unit)
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }

    private var languageSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Language").font(.headline)
            Toggle("Use device language", isOn: Binding(
                get: { viewModel.preferences.useDeviceLanguage },
                set: { viewModel.toggleDeviceLanguage($0) }
            ))
            if !viewModel.preferences.useDeviceLanguage {
                TextField("Language code", text: Binding(
                    get: { viewModel.preferences.customLanguageCode ?? "" },
                    set: { viewModel.updateLanguage($0) }
                ))
                .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }

    private var cacheSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cache").font(.headline)
            Toggle("Cache responses", isOn: Binding(
                get: { viewModel.preferences.cacheResponses },
                set: { viewModel.toggleCache($0) }
            ))
            SecondaryButton(title: "Clear cache") { viewModel.clearCache() }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("About").font(.headline)
            Text("Data by OpenWeather")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }
}
