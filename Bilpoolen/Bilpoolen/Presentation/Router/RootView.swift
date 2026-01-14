import SwiftUI

struct RootView: View {
    @ObservedObject var router: RootRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            router.rootView()
                .navigationDestination(for: RootRouter.Route.self) { route in
                    router.destination(for: route)
                }
        }
        .sheet(item: $router.activeModal) { modal in
            NavigationStack {
                router.modalView(for: modal)
            }
        }
        .overlay {
            BottomSheet(isPresented: Binding(
                get: { router.activeSheet != nil },
                set: { if !$0 { router.dismissSheet() } }
            )) {
                if let sheet = router.activeSheet {
                    router.sheetView(for: sheet)
                }
            }
        }
    }
}
