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
  @StateObject var forcastViewModel: ForecastViewModel
  @State var isFavoriteLocations: Bool = false
  @EnvironmentObject var locationService: LocationService
  @Environment(\.openURL) var openURL

  var body: some View {
      NavigationView {
        ZStack {
          if locationService.status == .available {
            Color(currentViewModel.current?.condition ?? "sunny")
                .ignoresSafeArea(.all)
              ScrollView {
                VStack {
                  CurrentView(vm: currentViewModel)
                  Spacer()
                  ForecastListView(vm: forcastViewModel, backgroundColor: currentViewModel.current?.condition ?? "sunny")
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
      }
      .accentColor(.white)
  }

  private var addButton: some View {
    NavigationLink(
      destination: FavoritesView(
        viewModel: FavoritesViewModel(repository: FavoriteLocationsRepository()))
      .background(currentViewModel.current?.condition != nil ? Color(currentViewModel.current!.condition) : Color.black),
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
