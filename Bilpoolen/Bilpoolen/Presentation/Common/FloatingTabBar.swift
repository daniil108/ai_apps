import SwiftUI

struct FloatingTabBar: View {
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let systemImage: String
    }

    let items: [Item]
    let selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        HStack(spacing: 14) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                Button(action: { onSelect(index) }) {
                    HStack(spacing: 8) {
                        Image(systemName: item.systemImage)
                            .font(.system(size: 16, weight: .semibold))
                        Text(item.title)
                            .font(AppFonts.medium(14))
                    }
                    .foregroundStyle(selectedIndex == index ? Color.white : AppColors.slate)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Capsule()
                            .fill(selectedIndex == index ? AppColors.navy : Color.clear)
                    )
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 10)
        )
    }
}
