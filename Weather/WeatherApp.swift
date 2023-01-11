//
//  WeatherApp.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI

@main
struct WeatherApp: App {
  @Environment(\.scenePhase) private var scenePhase
  let weatherService = WeatherService(network: DefaultNetworkService())
  @StateObject var locationService = LocationService()
  let coreDataRepository = CoreDataRepository()
  @State var backgroundColor: Color = Color("sunny")

  var body: some Scene {
    WindowGroup {
      ContentView(
        currentViewModel: CurrentViewModel(
          weatherService: weatherService,
          repository: coreDataRepository),
        forecastViewModel: ForecastViewModel(weatherService: weatherService),
        favoritesViewModel: FavoritesViewModel(
          repository: coreDataRepository,
          locationService: locationService))
      .environmentObject(locationService)
      .preferredColorScheme(.light)
    }
    // use onChange to detect when the scenePhase changes and when the app becomes
    // active, so check for location permissions.
    .onChange(of: scenePhase) { (newScenePhase) in
      switch newScenePhase {
        case .active:
          self.locationService.start()
        default:
          // ignore
          break
      }
    }
  }
}
