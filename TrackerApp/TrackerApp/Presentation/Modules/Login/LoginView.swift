import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer().frame(height: 24)
            Image("login_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .padding(.top, 24)
            VStack(spacing: 18) {
                InputField(title: "Email", placeholder: "johndoe@example.com", text: $viewModel.email)
                InputField(title: "Password", placeholder: "Enter password", text: $viewModel.password, isSecure: true)
            }
            VStack(spacing: 12) {
                PrimaryButton(title: "Log in", action: { viewModel.onLoginTapped() }, isLoading: viewModel.isLoading)
                SecondaryButton(title: "Register", action: { viewModel.onRegisterTapped() })
            }
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(Theme.error)
            }
            Button(action: { viewModel.onForgotPasswordTapped() }) {
                Text("Forgot password?")
                    .font(.system(size: 15))
                    .foregroundColor(Theme.text)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color.white.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
