import SwiftUI

struct CompanyInfoView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    InfoRow(title: "Company", value: "Bilpoolen AB")
                    Divider()
                    InfoRow(title: "Org no.", value: "556677-8899")
                    Divider()
                    InfoRow(title: "Address", value: "Sveavagen 12, Stockholm")
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Company info")
    }
}

private struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppFonts.medium(14))
                .foregroundStyle(AppColors.navy)
            Spacer()
            Text(value)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.slate)
        }
    }
}
