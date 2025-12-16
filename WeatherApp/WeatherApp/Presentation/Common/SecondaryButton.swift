import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).strokeBorder(.white.opacity(0.4), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .frame(height: 48)
    }
}
