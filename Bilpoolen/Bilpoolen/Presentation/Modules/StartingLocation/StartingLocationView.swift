import SwiftUI

struct StartingLocationView: View {
    @StateObject private var viewModel: StartingLocationViewModel

    init(viewModel: StartingLocationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    LocationRow(title: "Home", subtitle: "Hagagatan 19, Stockholm")
                    Divider()
                    LocationRow(title: "Office", subtitle: "Drottninggatan 8, Stockholm")
                }
            }

            PrimaryButton(title: "Add new", background: AppColors.navy) {
                viewModel.addNewTapped()
            }

            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Starting location")
    }
}

private struct LocationRow: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(AppFonts.medium(14))
                .foregroundStyle(AppColors.navy)
            Text(subtitle)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.slate)
        }
    }
}
