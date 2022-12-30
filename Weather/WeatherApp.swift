//
//  WeatherApp.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI

@main
struct WeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
