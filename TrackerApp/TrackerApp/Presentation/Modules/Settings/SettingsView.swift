import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.email)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Theme.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            PrimaryButton(title: "Export", action: { viewModel.onExport() })
            DestructiveButton(title: "Logout", action: { viewModel.onLogout() })
            Spacer()
        }
        .padding(20)
        .background(Color.white)
    }
}
