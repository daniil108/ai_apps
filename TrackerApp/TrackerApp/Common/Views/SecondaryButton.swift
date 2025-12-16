import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Theme.primary)
                .frame(maxWidth: .infinity, minHeight: 52)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Theme.primary, lineWidth: 1)
        )
    }
}
