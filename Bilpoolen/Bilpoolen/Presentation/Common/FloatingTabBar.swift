import SwiftUI

struct FloatingTabBar: View {
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
        let usesAsset: Bool
    }

    let items: [Item]
    let selectedIndex: Int
    let onSelect: (Int) -> Void

    var body: some View {
        HStack(spacing: 10) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                Button(action: { onSelect(index) }) {
                    HStack(spacing: 8) {
                        if item.usesAsset {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        } else {
                            Image(systemName: item.imageName)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        if selectedIndex == index {
                            Text(item.title)
                                .font(AppFonts.medium(14))
                        }
                    }
                    .foregroundStyle(selectedIndex == index ? Color.white : AppColors.slate)
                    .padding(.vertical, 8)
                    .padding(.horizontal, selectedIndex == index ? 14 : 10)
                    .background(
                        Capsule()
                            .fill(selectedIndex == index ? AppColors.navy : Color.clear)
                    )
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 10)
        )
    }
}
