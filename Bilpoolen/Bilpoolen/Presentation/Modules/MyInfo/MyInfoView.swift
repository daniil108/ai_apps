import SwiftUI

struct MyInfoView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    InfoRow(title: "Name", value: "Daniil Sentsov")
                    Divider()
                    InfoRow(title: "Email", value: "johndoe@example.com")
                    Divider()
                    InfoRow(title: "Phone", value: "+46 70 123 45 67")
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("My info")
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
