import SwiftUI

struct CostCentersView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    CostCenterRow(title: "Operations", code: "OPS-132")
                    Divider()
                    CostCenterRow(title: "Marketing", code: "MKT-402")
                    Divider()
                    CostCenterRow(title: "Research", code: "RND-018")
                }
            }
            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("Cost centers")
    }
}

private struct CostCenterRow: View {
    let title: String
    let code: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppFonts.medium(14))
                .foregroundStyle(AppColors.navy)
            Spacer()
            Text(code)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.slate)
        }
    }
}
