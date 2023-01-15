//
//  ContentView.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  let weatherService = WeatherService(network: DefaultNetworkService())
  let coreDataRepository = CoreDataRepository()
  @StateObject var currentViewModel: CurrentViewModel
  @StateObject var forecastViewModel: ForecastViewModel
  @StateObject var favoritesViewModel: FavoritesViewModel
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @EnvironmentObject var connectivity: Connectivity
  @Environment(\.openURL) var openURL
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    NavigationView {
      ZStack {
        if locationService.status == .waiting {
          ProgressView()
        } else {
          appBackgroundColor.wrappedValue
            .ignoresSafeArea(.all)
          ScrollView {
            VStack {
              CurrentView(vm: currentViewModel)
              Spacer()
              ForecastListView(vm: forecastViewModel)
            }
          }
          .edgesIgnoringSafeArea(.top)
        }

//        if locationService.status == .denied && currentViewModel.current == nil {
//          SelectLocationContent(action: {
//            openURL(URL(string: UIApplication.openSettingsURLString)!)
//          })
//        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          addButton
        }
        ToolbarItem(placement: .navigationBarLeading) {
          mapButton
        }
      }
      .navigationTitle("")
      .animation(Animation.easeInOut.speed(0.25), value: appBackgroundColor.wrappedValue)
    }
    .accentColor(.white)
  }

  private var addButton: some View {
    NavigationLink(
      destination: FavoritesView(viewModel: favoritesViewModel)) {
        Image(systemName: "list.bullet")
    }
  }

  private var mapButton: some View {
    NavigationLink(
      destination: MapView(viewModel: FavoritesViewModel(repository: coreDataRepository, locationService: locationService))) {
        Image(systemName: "map")
      }
  }
}
