import SwiftUI

struct CarDetailsView: View {
    let car: Car

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        Image(systemName: "car.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(AppColors.navy)
                            .frame(width: 72, height: 56)
                            .background(AppColors.lightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                        Text(car.name)
                            .font(AppFonts.title(18))
                            .foregroundStyle(AppColors.navy)
                        Text(car.plateNumber)
                            .font(AppFonts.medium(14))
                            .foregroundStyle(AppColors.slate)
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        DetailRow(title: "Location", value: car.locationName)
                        DetailRow(title: "Distance", value: car.distanceText)
                        DetailRow(title: "Battery", value: "85%")
                        DetailRow(title: "Range", value: "312 km")
                    }
                }

                PrimaryButton(title: "Select this car", background: AppColors.navy) {
                }
            }
            .padding(16)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Car Details")
    }
}

private struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.slate)
            Spacer()
            Text(value)
                .font(AppFonts.medium(13))
                .foregroundStyle(AppColors.navy)
        }
    }
}
