//
//  WeatherApp.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI

@main
struct WeatherApp: App {
    let weatherService = WeatherService()

    var body: some Scene {
        WindowGroup {
          ContentView(
            viewModel: CurrentViewModel(
            weatherService: weatherService),
            forcastViewModel: ForecastViewModel(weatherService: weatherService))
        }
    }
}
