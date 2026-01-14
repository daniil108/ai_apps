import SwiftUI

struct UpcomingBookingView: View {
    let booking: Booking

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            Image("car")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 44)
                                .padding(4)
                                .background(AppColors.lightGray)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(booking.car.name) - \(booking.car.plateNumber)")
                                    .font(AppFonts.medium(14))
                                    .foregroundStyle(AppColors.navy)
                                Text(booking.locationName)
                                    .font(AppFonts.body(12))
                                    .foregroundStyle(AppColors.slate)
                            }
                        }

                        Text("Thu, 14 Jun 12:00 - 20:00")
                            .font(AppFonts.body(12))
                            .foregroundStyle(AppColors.slate)

                        Text("Upcoming")
                            .font(AppFonts.body(12))
                            .foregroundStyle(AppColors.infoBlue)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 8)
                            .background(AppColors.infoBlue.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(16)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Upcoming booking")
    }
}
