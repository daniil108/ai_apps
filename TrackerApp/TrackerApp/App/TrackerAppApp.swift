import SwiftUI

@main
struct TrackerAppApp: App {
    private let container = DependencyContainer()
    private let appRouter: AppRouter

    init() {
        MockRegistrar.register(in: container)
        appRouter = AppRouter(container: container)
    }

    var body: some Scene {
        WindowGroup {
            RootView(router: appRouter)
        }
    }
}
