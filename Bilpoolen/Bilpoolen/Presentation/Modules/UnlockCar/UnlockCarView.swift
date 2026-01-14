import SwiftUI

struct UnlockCarView: View {
    @StateObject private var viewModel: UnlockCarViewModel

    init(viewModel: UnlockCarViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
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
                            Text("\(viewModel.booking.car.name) - \(viewModel.booking.car.plateNumber)")
                                .font(AppFonts.medium(14))
                                .foregroundStyle(AppColors.navy)
                            Text(viewModel.booking.locationName)
                                .font(AppFonts.body(12))
                                .foregroundStyle(AppColors.slate)
                        }
                    }

                    Text("Today 12:00 - 20:00")
                        .font(AppFonts.body(12))
                        .foregroundStyle(AppColors.slate)
                }
            }

            PrimaryButton(title: "Unlock and start trip", background: AppColors.accentGreen) {
                viewModel.unlockAndStartTripTapped()
            }

            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Unlock car")
    }
}
