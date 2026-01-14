import SwiftUI

extension View {
    func appNavigationTitle(_ title: String) -> some View {
        navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
