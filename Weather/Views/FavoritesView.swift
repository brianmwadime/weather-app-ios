//
//  FavoritesView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import SwiftUI
import MapKit

struct FavoritesView: View {
  @Environment(\.dismissSearch) var dismissSearch
  @StateObject var viewModel: FavoritesViewModel
  @ObservedObject var currentViewModel: CurrentViewModel
  @StateObject private var searchViewModel = LocationsViewModel()
  @State var query: String = ""
  @State private var selectedItem: MKMapItem?

  var body: some View {
    ZStack {
      Color.clear.ignoresSafeArea(.all)
      if query.isEmpty {
        ZStack {
          if viewModel.favorites.isEmpty {
            Text("search_prompt".localized())
              .foregroundColor(Color.white)
          }

          if let favorites = viewModel.favorites {
            List {
              ForEach(favorites) { favorite in
                ZStack {
                  NavigationLink(destination: Color.red) {
                    EmptyView()
                  }
                  .opacity(0.0)
                  .buttonStyle(.plain)
                  FavoriteCardView(favorite: favorite)
                }
//                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
              }
              .onDelete { idx in

              }
              .onAppear {
                UITableView.appearance().tableFooterView = UIView()
              }
            }
            .listStyle(.plain)
          }
        }
        .onAppear {
          let appearance = UINavigationBarAppearance()
          appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
          appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))

          // Inline appearance (standard height appearance)
          UINavigationBar.appearance().standardAppearance = appearance
          // Large Title appearance
          UINavigationBar.appearance().scrollEdgeAppearance = appearance
          self.viewModel.fetch()
        }
      }

      if !query.isEmpty {
        LocationSearchView(searchModel: searchViewModel, selectedItem: self.$selectedItem, query: self.query)
          .onChange(of: self.selectedItem) { location in
            if let place = location?.placemark {
              self.viewModel.save(
                city: place.title ?? "saved_location".localized(),
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude)
                dismissSearch()
            }
          }
      }
    }
    .navigationTitle("Weather")
    .searchable(
      text: $query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "Search for a city or airport".localized())
      .onChange(of: self.query) { (value) in
        self.searchViewModel.search(for: value)

      }
  }
}
