//
//  ContentView.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @StateObject var currentViewModel: CurrentViewModel
  @StateObject var forecastViewModel: ForecastViewModel
  @StateObject var favoritesViewModel: FavoritesViewModel
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @Environment(\.openURL) var openURL

  var body: some View {
      NavigationView {
        ZStack {
          if locationService.status == .available {
            Color(currentViewModel.condition)
                .ignoresSafeArea(.all)
              ScrollView {
                VStack {
                  CurrentView(vm: currentViewModel)
                  Spacer()
                  ForecastListView(vm: forecastViewModel, backgroundColor: currentViewModel.condition)
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
        .animation(Animation.easeInOut.speed(0.25), value: currentViewModel.condition)
      }
      .accentColor(.white)
  }

  private var addButton: some View {
    NavigationLink(
      destination: FavoritesView(viewModel: favoritesViewModel, currentViewModel: currentViewModel, condition: currentViewModel.condition)
      .background(Color(currentViewModel.condition)),
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
      destination: MapView(viewModel: favoritesViewModel)) {
        Image(systemName: "map")
      }
  }
}
