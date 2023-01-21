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
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.openURL) var openURL
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    NavigationView {
      ZStack {
        appBackgroundColor.wrappedValue
          .ignoresSafeArea()
      switch locationService.status {
          case .waiting:
            ProgressView()
          case .denied:
            if currentViewModel.current != nil {
              weatherView
            } else {
              SelectLocationContent(action: {
                openURL(URL(string: UIApplication.openSettingsURLString)!)
              })
            }
          case .available:
            if currentViewModel.current != nil {
              weatherView
            } else {
              SelectLocationContent(action: {
                openURL(URL(string: UIApplication.openSettingsURLString)!)
              })
            }
        }
      }
      .onChange(of: locationService.lastLocation, perform: { newValue in
        currentViewModel.fetchCurrent(for: newValue)
        forecastViewModel.fetchForecast(for: newValue)
      })
      .onChange(of: currentViewModel.condition, perform: { newValue in
        appBackgroundColor.wrappedValue = Color(newValue)
      })
      .onAppear {
        currentViewModel.fetchCurrent(for: locationService.lastLocation)
        forecastViewModel.fetchForecast(for: locationService.lastLocation)
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
    .accentColor(colorScheme == .dark ? .white : .black)
  }

  private var weatherView: some View {
    ScrollView {
      VStack {
        CurrentView(vm: currentViewModel)
        Spacer()
        ForecastListView(vm: forecastViewModel)
      }
    }
    .edgesIgnoringSafeArea(.top)
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
