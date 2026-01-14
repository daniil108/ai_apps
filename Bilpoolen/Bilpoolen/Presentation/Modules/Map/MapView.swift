import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 0.78, green: 0.86, blue: 0.94), Color(red: 0.9, green: 0.94, blue: 0.98)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 280)

                    VStack(spacing: 8) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 32))
                            .foregroundStyle(AppColors.navy)
                        Text("Available cars on map")
                            .font(AppFonts.medium(14))
                            .foregroundStyle(AppColors.navy)
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Tap a car to see details")
                        .font(AppFonts.body(12))
                        .foregroundStyle(AppColors.slate)

                    ForEach(viewModel.cars) { car in
                        Button(action: { viewModel.carTapped(car) }) {
                            CardView {
                                HStack(spacing: 12) {
                                    Image(systemName: "car.fill")
                                        .font(.system(size: 26))
                                        .foregroundStyle(AppColors.navy)
                                        .frame(width: 50, height: 38)
                                        .background(AppColors.lightGray)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(car.name)
                                            .font(AppFonts.medium(14))
                                            .foregroundStyle(AppColors.navy)
                                        Text(car.locationName)
                                            .font(AppFonts.body(12))
                                            .foregroundStyle(AppColors.slate)
                                    }
                                    Spacer()
                                    Text(car.distanceText)
                                        .font(AppFonts.body(12))
                                        .foregroundStyle(AppColors.slate)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Map")
        .onAppear {
            viewModel.onAppear()
        }
    }
}
