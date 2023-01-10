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

  init() {
    applyNavigationStyling()
  }

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

  func applyNavigationStyling() {
    // this is not the same as manipulating the proxy directly
    let appearance = UINavigationBarAppearance()

    // this overrides everything you have set up earlier.
    appearance.configureWithTransparentBackground()

    // this only applies to big titles
    appearance.largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    // this only applies to small titles
    appearance.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white
    ]

    // In the following two lines you make sure that you apply the style for good
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactScrollEdgeAppearance = appearance

    // This property is not present on the UINavigationBarAppearance
    // object for some reason and you have to leave it til the end
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().barTintColor = .white

    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
  }
}
