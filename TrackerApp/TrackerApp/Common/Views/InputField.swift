import SwiftUI

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Theme.text)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textContentType(.password)
                    .padding(.horizontal, 12)
                    .frame(height: 44)
                    .background(RoundedRectangle(cornerRadius: 6).stroke(Theme.border))
            } else {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 12)
                    .frame(height: 44)
                    .background(RoundedRectangle(cornerRadius: 6).stroke(Theme.border))
            }
        }
    }
}
