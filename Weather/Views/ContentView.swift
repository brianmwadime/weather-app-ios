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
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @Environment(\.openURL) var openURL
  let favoritesRepository = FavoriteLocationsRepository()

  var body: some View {
      NavigationView {
        ZStack {
          if locationService.status == .available {
            Color(currentViewModel.condition ?? "sunny")
                .ignoresSafeArea(.all)
              ScrollView {
                VStack {
                  CurrentView(vm: currentViewModel)
                  Spacer()
                  ForecastListView(vm: forecastViewModel, backgroundColor: currentViewModel.condition ?? "sunny")
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
        }
        .navigationTitle("")
        .animation(Animation.easeInOut.speed(0.25), value: currentViewModel.condition)
      }
      .accentColor(.white)
  }

  private var addButton: some View {
    NavigationLink(
      destination: FavoritesView(currentViewModel: currentViewModel, condition: currentViewModel.condition)
      .background(currentViewModel.condition != nil ? Color(currentViewModel.condition!) : Color.black),
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
}
