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
  @Environment(\.openURL) var openURL
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    NavigationView {
      ZStack {
        if locationService.status == .available {
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

        if locationService.status == .waiting {
          ProgressView()
        }

        if locationService.status == .denied {
          SelectLocationContent(action: {
            openURL(URL(string: UIApplication.openSettingsURLString)!)
          })
        }
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
      destination: FavoritesView(viewModel: favoritesViewModel),
      isActive: $isFavoriteLocations) {
      Button {
        self.isFavoriteLocations = true
      } label: {
        Image(systemName: "list.bullet")
          .imageScale(.medium)
          .tint(.white)
          .font(.title)
      }
    }
  }

  private var mapButton: some View {
    NavigationLink(
      destination: MapView(viewModel: FavoritesViewModel(repository: coreDataRepository, locationService: locationService))) {
        Image(systemName: "map")
      }
  }
}
