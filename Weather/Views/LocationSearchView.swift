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
      Color.clear.ignoresSafeArea(.all)
      VStack(alignment: .center) {
        if self.searchModel.locations.isEmpty {
          if self.searchModel.isSearching {
            VStack(alignment: .center, spacing: 0) {
              Text("no_results".localized())
                .foregroundColor(Color.white)
                .font(.headline)
                .padding(.horizontal)
              Text("no_results_description \(query)")
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                .font(.body)
                .padding(.horizontal)
            }
          }
        } else {
          List(searchModel.locations, id: \.self) { term in
            VStack(alignment: .leading) {
              Text(term)
                .font(.headline)
                .foregroundColor(Color.white)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .contentShape(Rectangle())
            .onTapGesture {
              self.searchModel.mapItem(for: term) { mapItem in
                self.selectedItem = mapItem
//                dismissSearch()
              }
            }
          }
          .listStyle(.plain)
        }
      }
    }
  }
}
