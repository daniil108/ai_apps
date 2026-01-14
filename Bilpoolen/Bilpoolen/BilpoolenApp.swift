//
//  BilpoolenApp.swift
//  Bilpoolen
//
//  Created by Daniil Sentsov on 14.01.26.
//

import SwiftUI

@main
struct BilpoolenApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            RootView(router: RootRouter(container: container))
        }
    }
}
