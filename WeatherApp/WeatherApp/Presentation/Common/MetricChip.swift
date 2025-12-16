import SwiftUI

struct MetricChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
