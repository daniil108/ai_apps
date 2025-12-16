import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String
    let systemImage: String?

    var body: some View {
        HStack {
            if let systemImage {
                Image(systemName: systemImage)
                    .frame(width: 20)
            }
            Text(title)
            Spacer()
            Text(value)
                .bold()
        }
        .padding(.vertical, 4)
    }
}
