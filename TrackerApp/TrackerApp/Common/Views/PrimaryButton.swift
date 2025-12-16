import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var leadingSystemImage: String?
    var isLoading: Bool = false
    var disabled: Bool = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else if let icon = leadingSystemImage {
                    Image(systemName: icon)
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 52)
        }
        .disabled(disabled || isLoading)
        .background(Theme.primary.opacity(disabled ? 0.4 : 1))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
