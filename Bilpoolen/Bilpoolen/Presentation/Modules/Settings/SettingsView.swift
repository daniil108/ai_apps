import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    SettingsRow(title: "Language", value: "System (English)") {
                        viewModel.languageTapped()
                    }
                    Divider()
                    SettingsRow(title: "Starting location", value: "Home") {
                        viewModel.startingLocationTapped()
                    }
                    Divider()
                    SettingsRow(title: "Cost centers", value: nil) {
                        viewModel.costCentersTapped()
                    }
                    Divider()
                    SettingsRow(title: "Past bookings", value: nil) {
                        viewModel.pastBookingsTapped()
                    }
                    Divider()
                    SettingsRow(title: "My info", value: nil) {
                        viewModel.myInfoTapped()
                    }
                    Divider()
                    SettingsRow(title: "Company info", value: nil) {
                        viewModel.companyInfoTapped()
                    }
                    Divider()
                    SettingsRow(title: "Customer service", value: nil) {
                        viewModel.customerServiceTapped()
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 6)

                PrimaryButton(title: "Logout", background: AppColors.alertRed) {
                    viewModel.logoutTapped()
                }
            }
            .padding(16)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Settings")
    }
}

private struct SettingsRow: View {
    let title: String
    let value: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.navy)
                Spacer()
                if let value {
                    Text(value)
                        .font(AppFonts.body(13))
                        .foregroundStyle(AppColors.slate)
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.midGray)
            }
            .padding(14)
        }
        .buttonStyle(.plain)
    }
}
