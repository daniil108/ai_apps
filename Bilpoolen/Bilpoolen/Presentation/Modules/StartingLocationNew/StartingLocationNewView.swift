import SwiftUI

struct StartingLocationNewView: View {
    @State private var name = ""
    @State private var address = ""

    var body: some View {
        VStack(spacing: 16) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Name")
                        .font(AppFonts.medium(13))
                        .foregroundStyle(AppColors.slate)
                    TextField("Home", text: $name)
                        .padding(12)
                        .background(AppColors.lightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("Address")
                        .font(AppFonts.medium(13))
                        .foregroundStyle(AppColors.slate)
                    TextField("Street, City", text: $address)
                        .padding(12)
                        .background(AppColors.lightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }

            PrimaryButton(title: "Save", background: AppColors.navy) {
            }

            Spacer()
        }
        .padding(16)
        .background(AppColors.lightGray.ignoresSafeArea())
        .appNavigationTitle("New starting location")
    }
}
