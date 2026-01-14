import SwiftUI

struct FiltersView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Car type")
                            .font(AppFonts.medium(14))
                            .foregroundStyle(AppColors.navy)
                        HStack(spacing: 8) {
                            FilterChip(title: "Small")
                            FilterChip(title: "Family")
                            FilterChip(title: "Electric")
                        }
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Seats")
                            .font(AppFonts.medium(14))
                            .foregroundStyle(AppColors.navy)
                        HStack(spacing: 8) {
                            FilterChip(title: "2")
                            FilterChip(title: "4")
                            FilterChip(title: "5+")
                        }
                    }
                }

                PrimaryButton(title: "Apply filters", background: AppColors.navy) {
                }
            }
            .padding(16)
        }
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Filters")
    }
}

private struct FilterChip: View {
    let title: String

    var body: some View {
        Text(title)
            .font(AppFonts.medium(12))
            .foregroundStyle(AppColors.navy)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(AppColors.lightGray)
            .clipShape(Capsule())
    }
}
