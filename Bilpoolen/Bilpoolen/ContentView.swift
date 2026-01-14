//
//  ContentView.swift
//  Bilpoolen
//
//  Created by Daniil Sentsov on 14.01.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView(router: RootRouter(container: AppContainer()))
    }
}

#Preview {
    ContentView()
}
