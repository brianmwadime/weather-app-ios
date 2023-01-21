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
  let coreDataRepository = CoreDataRepository()
  @StateObject var connectivity = Connectivity()
  @StateObject var locationService = LocationService()
  @State var backgroundColor: Color = Color("sunny")

  init() {
    applyNavigationStyling()
  }

  var body: some Scene {
    WindowGroup {
      ContentView(
        currentViewModel: CurrentViewModel(
          weatherService: weatherService,
          repository: coreDataRepository),
        forecastViewModel: ForecastViewModel(
          weatherService: weatherService,
          repository: coreDataRepository),
        favoritesViewModel: FavoritesViewModel(
          repository: coreDataRepository,
          locationService: locationService))
      .environmentObject(locationService)
      .environmentObject(connectivity)
      .environment(\.appBackgroundColor, $backgroundColor)
    }
    .onChange(of: scenePhase) { (newScenePhase) in
      switch newScenePhase {
        case .active:
          self.connectivity.start()
          self.locationService.start()
        case .inactive:
          self.locationService.stop()
        default:
          break
      }
    }
  }

  func applyNavigationStyling() {

    let appearance = UINavigationBarAppearance()

    appearance.configureWithTransparentBackground()

    appearance.shadowImage = UIImage()
    appearance.shadowColor = .clear

    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactScrollEdgeAppearance = appearance

  }
}
