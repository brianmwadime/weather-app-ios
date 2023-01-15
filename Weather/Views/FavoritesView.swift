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
      Color.black
        .ignoresSafeArea(.all)
      if query.isEmpty {
        ZStack {
          if viewModel.favorites.isEmpty {
            Text("search_prompt".localized())
              .foregroundColor(Color.white)
          }

          if let favorites = viewModel.favorites {
            List {
              ForEach(favorites) { favorite in
                FavoriteCardView(favorite: favorite)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
//                .listRowInsets(.none)
              }
              .onDelete { idx in
                self.viewModel.deleteItems(idx)
              }
              .onAppear {
                UITableView.appearance().tableFooterView = UIView()
              }
            }
            .padding(
              EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            )
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
            hideKeyboard()
            if let place = location?.placemark {
              self.viewModel.save(
                city: place.title ?? "saved_location".localized(),
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude)
            }
          }
      }
    }
    // Note: ios 16+
    // .toolbarBackground((condition != nil) ? Color(condition!) : Color.clear, for: .navigationBar)
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
}
