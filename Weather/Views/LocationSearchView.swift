//
//  LocationSearchViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
  @Environment(\.dismissSearch) private var dismissSearch
  @ObservedObject var searchModel: LocationSearchViewModel
  @Binding var selectedItem: MKMapItem?
  var query: String = ""

  var body: some View {
    ZStack {
      Color.clear.ignoresSafeArea()
      VStack(alignment: .center) {
        switch (searchModel.isSearching, searchModel.locations) {
          case (_, let locations) where !locations.isEmpty:
            List(locations, id: \.self) { term in
              VStack(alignment: .leading) {
                Text(term)
                  .font(.headline)
              }
              .listRowBackground(Color.clear)
              .listRowSeparator(.hidden)
              .contentShape(Rectangle())
              .onTapGesture {
                self.searchModel.mapItem(for: term) { mapItem in
                  self.selectedItem = mapItem
                  hideKeyboard()
                  dismissSearch()
                }
              }
            }
            .listStyle(.plain)
          case (let isSearching, let locations) where isSearching == true && locations.isEmpty:
            VStack(alignment: .center, spacing: 0) {
              Text("no_results".localized())
                .font(.headline)
                .padding(.horizontal)
              Text("no_results_description \(query)")
                .multilineTextAlignment(.center)
                .font(.body)
                .padding(.horizontal)
            }
          case (_, _):
            if let error = searchModel.error {
              VStack(alignment: .center, spacing: 0) {
                Text("no_search".localized())
                  .font(.title)
                  .padding(.horizontal)
                Text(error.localizedDescription)
                  .multilineTextAlignment(.center)
                  .font(.body)
                  .padding(.horizontal)
              }
            }
        }
      }
    }
  }
}
