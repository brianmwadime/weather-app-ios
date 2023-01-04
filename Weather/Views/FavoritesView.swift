//
//  FavoritesView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import SwiftUI

struct FavoritesView: View {
  @StateObject var viewModel: FavoritesViewModel

  var body: some View {
    ZStack {
      Color.clear.ignoresSafeArea(.all)
      if viewModel.favorites.isEmpty {
        Text("Search for a city to add to favorites".localized())
          .foregroundColor(Color.white)
      }

      if let favorites = viewModel.favorites {
        List {
          ForEach(favorites) { favorite in
            Text(favorite.city)
          }
          .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
      }
    }
    .navigationTitle("Weather")
    .searchable(
      text: $viewModel.query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "Search for a city or airport".localized())
  }
}
