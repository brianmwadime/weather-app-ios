//
//  ContentView.swift
//  Weather
//
//  Created by Brian Mwakima on 12/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @ObservedObject var currentViewModel: CurrentViewModel
  @ObservedObject var forecastViewModel: ForecastViewModel
  @ObservedObject var favoritesViewModel: FavoritesViewModel
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @Environment(\.openURL) var openURL
  @Environment(\.appBackgroundColor) var appBackgroundColor

  init(currentViewModel: CurrentViewModel,
       forecastViewModel: ForecastViewModel,
       favoritesViewModel: FavoritesViewModel) {
    self.currentViewModel = currentViewModel
    self.favoritesViewModel = favoritesViewModel
    self.forecastViewModel = forecastViewModel

    applyNavigationStyling()
  }

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

//    appearance.backgroundColor = UIColor(appBackgroundColor)
    appearance.shadowImage = UIImage()
    appearance.shadowColor = .clear

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
