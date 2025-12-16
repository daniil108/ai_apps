import SwiftUI

struct DestructiveButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
        }
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
