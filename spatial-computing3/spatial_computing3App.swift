//
//  spatial_computing3App.swift
//  spatial-computing3
//
//  Created by David Garcia on 10/15/23.
//

import SwiftUI

@main
struct spatial_computing3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
