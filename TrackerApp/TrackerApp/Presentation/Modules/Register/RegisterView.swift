import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel

    init(viewModel: RegisterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 24) {
            Image("login_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .padding(.top, 12)
            VStack(spacing: 18) {
                InputField(title: "Email", placeholder: "johndoe@example.com", text: $viewModel.email)
                InputField(title: "Password", placeholder: "Enter password", text: $viewModel.password, isSecure: true)
            }
            PrimaryButton(title: "Register", action: { viewModel.onRegisterTapped() }, isLoading: viewModel.isLoading)
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(Theme.error)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Registration")
        .navigationBarTitleDisplayMode(.inline)
    }
}
