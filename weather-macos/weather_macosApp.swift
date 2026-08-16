//
//  weather_macosApp.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/15/26.
//

import SwiftUI

@main
struct weather_macosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 600, height: 400)
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
}
