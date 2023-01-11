//
//  ContentView.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.scenePhase) private var scenePhase
  @ObservedObject var currentViewModel: CurrentViewModel
  @ObservedObject var forecastViewModel: ForecastViewModel
  @ObservedObject var favoritesViewModel: FavoritesViewModel
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @Environment(\.openURL) var openURL
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    NavigationView {
      ZStack {
        if locationService.status == .available {
          Color(currentViewModel.condition)
              .ignoresSafeArea(.all)
              .setAppBackgroundColor(Color(currentViewModel.condition))
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
