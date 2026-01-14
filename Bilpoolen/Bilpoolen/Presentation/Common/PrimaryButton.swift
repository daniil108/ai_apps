import SwiftUI

struct PrimaryButton: View {
    let title: String
    let background: Color
    let foreground: Color
    let action: () -> Void

    init(title: String, background: Color = AppColors.navy, foreground: Color = .white, action: @escaping () -> Void) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFonts.medium(16))
                .foregroundStyle(foreground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(background)
                .clipShape(Capsule())
        }
    }
}
