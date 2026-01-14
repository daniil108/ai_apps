import SwiftUI

struct PastBookingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    PastBookingRow(title: "Toyota Corolla Kombi", date: "Mon, 3 Jun")
                    Divider()
                    PastBookingRow(title: "Volvo XC40 Recharge", date: "Thu, 23 May")
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Past bookings")
    }
}

private struct PastBookingRow: View {
    let title: String
    let date: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppFonts.medium(14))
                .foregroundStyle(AppColors.navy)
            Spacer()
            Text(date)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.slate)
        }
    }
}
