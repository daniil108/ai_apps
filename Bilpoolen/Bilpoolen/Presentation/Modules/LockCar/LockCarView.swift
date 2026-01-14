import SwiftUI

struct LockCarView: View {
    let booking: Booking

    var body: some View {
        VStack(spacing: 20) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(AppColors.navy)
                            .frame(width: 64, height: 44)
                            .background(AppColors.lightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Trip started")
                                .font(AppFonts.title(16))
                                .foregroundStyle(AppColors.navy)
                            Text("\(booking.car.name) - \(booking.car.plateNumber)")
                                .font(AppFonts.body(12))
                                .foregroundStyle(AppColors.slate)
                        }
                    }

                    Text("Remember to lock the car when you end the trip.")
                        .font(AppFonts.body(12))
                        .foregroundStyle(AppColors.slate)
                }
            }

            PrimaryButton(title: "Lock car", background: AppColors.navy) {
            }

            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Lock car")
    }
}
