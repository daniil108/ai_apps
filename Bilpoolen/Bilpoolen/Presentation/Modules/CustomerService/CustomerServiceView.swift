import SwiftUI

struct CustomerServiceView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    ServiceRow(title: "Support", value: "+46 8 123 45 00")
                    Divider()
                    ServiceRow(title: "Email", value: "support@bilpoolen.nu")
                    Divider()
                    ServiceRow(title: "Hours", value: "Mon-Fri 08:00-18:00")
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Customer service")
    }
}

private struct ServiceRow: View {
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
