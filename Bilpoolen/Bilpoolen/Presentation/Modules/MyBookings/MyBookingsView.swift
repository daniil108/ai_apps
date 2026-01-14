import SwiftUI

struct MyBookingsView: View {
    @ObservedObject var viewModel: MyBookingsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Active bookings")
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.slate)

                if let booking = viewModel.activeBooking {
                    Button(action: { viewModel.activeBookingTapped() }) {
                        BookingRowView(booking: booking, statusLabel: "Active", statusColor: AppColors.accentGreen)
                    }
                    .buttonStyle(.plain)
                }

                Text("Future bookings")
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.slate)
                    .padding(.top, 6)

                ForEach(viewModel.upcomingBookings) { booking in
                    Button(action: { viewModel.upcomingBookingTapped(booking) }) {
                        BookingRowView(booking: booking, statusLabel: "Upcoming", statusColor: AppColors.infoBlue)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
            .padding(.bottom, 90)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("My Bookings")
        .onAppear {
            viewModel.onAppear()
        }
    }
}

private struct BookingRowView: View {
    let booking: Booking
    let statusLabel: String
    let statusColor: Color

    var body: some View {
        CardView {
            HStack(spacing: 12) {
                Image(systemName: "car.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(AppColors.navy)
                    .frame(width: 52, height: 40)
                    .background(AppColors.lightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(booking.car.name) - \(booking.car.plateNumber)")
                        .font(AppFonts.medium(14))
                        .foregroundStyle(AppColors.navy)
                    Text(booking.locationName)
                        .font(AppFonts.body(12))
                        .foregroundStyle(AppColors.slate)

                    Text(statusLabel)
                        .font(AppFonts.body(12))
                        .foregroundStyle(statusColor)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(statusColor.opacity(0.15))
                        .clipShape(Capsule())
                }

                Spacer()

                Text("Wed, 13 Jun 12:00 - 20:00")
                    .font(AppFonts.body(11))
                    .foregroundStyle(AppColors.slate)
            }
        }
    }
}
