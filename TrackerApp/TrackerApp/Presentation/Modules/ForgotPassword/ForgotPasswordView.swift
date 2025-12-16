import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel: ForgotPasswordViewModel

    init(viewModel: ForgotPasswordViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer().frame(height: 80)
            InputField(title: "Email", placeholder: "johndoe@example.com", text: $viewModel.email)
            PrimaryButton(title: "Restore password", action: { viewModel.onRestoreTapped() }, isLoading: viewModel.isLoading)
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(Theme.error)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Forgot password")
        .navigationBarTitleDisplayMode(.inline)
    }
}
