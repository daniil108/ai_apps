import SwiftUI

struct NewBookingView: View {
    @ObservedObject var viewModel: NewBookingViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let booking = viewModel.activeBooking {
                    Text("Active booking")
                        .font(AppFonts.medium(14))
                        .foregroundStyle(AppColors.slate)

                    CardView {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "car.fill")
                                    .font(.system(size: 36))
                                    .foregroundStyle(AppColors.navy)
                                    .frame(width: 64, height: 44)
                                    .background(AppColors.lightGray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(booking.car.name) - \(booking.car.plateNumber)")
                                        .font(AppFonts.medium(14))
                                        .foregroundStyle(AppColors.navy)
                                    Text(booking.locationName)
                                        .font(AppFonts.body(12))
                                        .foregroundStyle(AppColors.slate)

                                    Text("Ready for trip")
                                        .font(AppFonts.body(12))
                                        .foregroundStyle(AppColors.accentGreen)
                                        .padding(.vertical, 2)
                                        .padding(.horizontal, 8)
                                        .background(AppColors.accentGreen.opacity(0.15))
                                        .clipShape(Capsule())
                                }
                            }

                            Text("Today 12:00 - 20:00")
                                .font(AppFonts.medium(12))
                                .foregroundStyle(AppColors.slate)

                            PrimaryButton(title: "Unlock and start trip", background: AppColors.accentGreen) {
                                viewModel.unlockAndStartTripTapped()
                            }
                        }
                    }
                }

                Text("New booking")
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.slate)

                CardView {
                    VStack(spacing: 14) {
                        BookingFieldRow(title: "Start time", value: "Wed, 13 Jun 16:00")
                        BookingFieldRow(title: "End time", value: "Thu, 13 Jun 22:00")
                        BookingFieldRow(title: "Place", value: "Home", showsChevron: true)

                        Button("Advanced filters") {
                            viewModel.advancedFiltersTapped()
                        }
                        .font(AppFonts.body(13))
                        .foregroundStyle(AppColors.infoBlue)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        PrimaryButton(title: "Search", background: AppColors.navy) {
                            viewModel.searchTapped()
                        }
                    }
                }

                if viewModel.isSearching {
                    if viewModel.hasConflict {
                        Text("Some cars are not available for the selected period")
                            .font(AppFonts.body(12))
                            .foregroundStyle(AppColors.alertRed)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Available cars")
                            .font(AppFonts.medium(14))
                            .foregroundStyle(AppColors.slate)

                        ForEach(viewModel.availableCars) { car in
                            Button(action: { viewModel.carTapped(car) }) {
                                CardView {
                                    HStack(spacing: 12) {
                                        Image(systemName: "car.fill")
                                            .font(.system(size: 28))
                                            .foregroundStyle(AppColors.navy)
                                            .frame(width: 52, height: 40)
                                            .background(AppColors.lightGray)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("\(car.name) - \(car.plateNumber)")
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
            }
            .padding(16)
            .padding(.bottom, 90)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("New Booking")
        .toolbar {
            if viewModel.isSearching {
                ToolbarItem(placement: .principal) {
                    Picker("Search Mode", selection: $viewModel.searchMode) {
                        Text("List").tag(NewBookingViewModel.SearchMode.list)
                        Text("Map").tag(NewBookingViewModel.SearchMode.map)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180)
                    .onChange(of: viewModel.searchMode) { mode in
                        if mode == .map {
                            viewModel.mapSelected()
                            viewModel.searchMode = .list
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

private struct BookingFieldRow: View {
    let title: String
    let value: String
    var showsChevron: Bool = false

    var body: some View {
        HStack {
            Text(title)
                .font(AppFonts.body(13))
                .foregroundStyle(AppColors.slate)
            Spacer()
            Text(value)
                .font(AppFonts.medium(13))
                .foregroundStyle(AppColors.navy)
            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.midGray)
            }
        }
        .padding(.vertical, 4)
    }
}
