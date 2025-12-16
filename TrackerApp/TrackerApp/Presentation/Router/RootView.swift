import SwiftUI

struct RootView: View {
    @ObservedObject var router: AppRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch router.rootScreen {
                case .loading:
                    Color.white.ignoresSafeArea().overlay(ProgressView())
                case .login:
                    LoginModuleBuilder.build(container: router.container, router: router)
                case .main:
                    MainModuleBuilder.build(container: router.container, router: router)
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .register:
                    RegisterModuleBuilder.build(container: router.container, router: router)
                case .forgotPassword:
                    ForgotPasswordModuleBuilder.build(container: router.container, router: router)
                case .newMeasurement:
                    NewMeasurementModuleBuilder.build(container: router.container, router: router)
                case .savedMeasurement(let measurement):
                    SavedMeasurementModuleBuilder.build(container: router.container, router: router, measurement: measurement)
                }
            }
        }
        .task {
            router.start()
        }
        .sheet(isPresented: $router.isSettingsVisible) {
            SettingsModuleBuilder.build(
                container: router.container,
                router: router,
                userEmail: router.userEmail
            )
            .presentationDetents([.fraction(0.45), .medium])
            .presentationDragIndicator(.visible)
        }
    }
}
