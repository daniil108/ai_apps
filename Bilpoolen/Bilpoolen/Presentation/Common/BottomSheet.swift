import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content

    @State private var offset: CGFloat = 0

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isPresented = false
                        }
                    }

                VStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Capsule()
                            .fill(AppColors.midGray)
                            .frame(width: 48, height: 5)
                            .padding(.top, 8)

                        content
                            .padding(.bottom, 24)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .offset(y: max(offset, 0))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > 120 {
                                    withAnimation(.spring()) {
                                        isPresented = false
                                    }
                                }
                                withAnimation(.spring()) {
                                    offset = 0
                                }
                            }
                    )
                }
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.2), value: isPresented)
            }
        }
    }
}
