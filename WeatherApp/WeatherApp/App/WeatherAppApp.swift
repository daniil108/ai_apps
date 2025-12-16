import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject private var router = AppEnvironment.bootstrap()

    var body: some Scene {
        WindowGroup {
            router.rootView()
        }
    }
}
