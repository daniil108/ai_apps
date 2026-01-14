import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 18) {
            Spacer()

            VStack(spacing: 12) {
                Image("login_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                    .padding(.bottom, 10)

            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.slate)
                TextField("johndoe@example.com", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding(12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppColors.midGray, lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.slate)
                SecureField("******", text: $viewModel.password)
                    .padding(12)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppColors.midGray, lineWidth: 1)
                    )
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(AppFonts.body(12))
                    .foregroundStyle(AppColors.alertRed)
            }

            PrimaryButton(title: viewModel.isLoading ? "Logging in..." : "Log in", background: AppColors.navy) {
                viewModel.loginTapped()
            }
            .disabled(viewModel.isLoading)

            Button("Forgot password?") {
            }
            .font(AppFonts.body(14))
            .foregroundStyle(AppColors.slate)

            Button("Become a member") {
            }
            .font(AppFonts.body(14))
            .foregroundStyle(AppColors.slate)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(AppColors.lightGray.ignoresSafeArea())
    }
}
