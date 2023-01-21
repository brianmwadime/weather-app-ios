//
//  FavoritesView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import SwiftUI
import MapKit

struct FavoritesView: View {
  @AppStorage("units") var units: Int = Constants.UnitsType.metric.rawValue
  @StateObject var viewModel: FavoritesViewModel
  @StateObject private var searchViewModel = LocationSearchViewModel()
  @State var query: String = ""
  @State private var selectedItem: MKMapItem?

  var body: some View {
    ZStack {
//      Color.primary
//        .ignoresSafeArea()
      if query.isEmpty {
        ZStack {
          if viewModel.getAnnotations().isEmpty {
            Text("search_prompt".localized())
          }

          if let favorites = viewModel.getAnnotations() {
            List {
              ForEach(favorites) { favorite in
                FavoriteCardView(favorite: favorite)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(.none)
                .swipeActions {
                  if !favorite.isMyLocation {
                    Button(role: .destructive) {
                      self.viewModel.delete(favorite)
                      self.viewModel.fetch()
                    } label: {
                      Image(systemName: "trash.fill")
                    }
                    .cornerRadius(10)
                  }
                }
              }
              .onAppear {
                UITableView.appearance().tableFooterView = UIView()
              }
            }
            .listStyle(.plain)
            .refreshable {
              viewModel.fetch()
            }
          }
        }
        .onAppear {
          viewModel.fetch()
        }
      }

      if !query.isEmpty {
        LocationSearchView(searchModel: searchViewModel, selectedItem: $selectedItem, query: self.query)
          .onChange(of: self.selectedItem) { location in
            if let place = location?.placemark {
              self.viewModel.save(
                city: place.title ?? "saved_location".localized(),
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude)
            }
          }
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Menu {
          Picker(selection: $units, label: Text("Units options")) {
            HStack {
              Text("Celcius")
              Spacer()
              Text("°C")
            }
            .tag(0)
            HStack {
              Text("Farenheit")
              Spacer()
              Text("F")
            }
            .tag(1)
          }
          .onChange(of: units) { value in
            viewModel.fetch()
          }
          Button("Remove All", action: removeAll)
          Button("Clear Forcast", action: clearForcast)
        } label: {
          Image(systemName: "ellipsis.circle")
        }
      }
    }
    .navigationBarTitle("favorites_screen_title".localized(), displayMode: .automatic)
    .searchable(
      text: $query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "search_prompt".localized())
      .onChange(of: self.query) { (value) in
        self.searchViewModel.search(for: value)
      }
  }

  private func removeAll() {
    viewModel.removeAll()
  }

  private func clearForcast() {
    viewModel.clearForcast()
  }
}
