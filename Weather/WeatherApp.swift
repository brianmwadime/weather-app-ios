//
//  WeatherApp.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI

@main
struct WeatherApp: App {
  let weatherService = WeatherService(network: DefaultNetworkService())

    var body: some Scene {
        WindowGroup {
          ContentView(
            currentViewModel: CurrentViewModel(
            weatherService: weatherService),
            forcastViewModel: ForecastViewModel(weatherService: weatherService))
        }
    }
}
