//
//  ForecastListView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import SwiftUI

struct ForecastListView: View {
  @ObservedObject var vm: ForecastViewModel
  var backgroundColor: String
  @EnvironmentObject var locationService: LocationService

  var body: some View {
    ZStack {
      Color(backgroundColor)
      VStack(spacing: 0) {
        Divider()
          .frame(height: 16)
          .overlay(Color(backgroundColor))
        VStack(spacing: 8.0) {
          ForEach(vm.forecast?.fiveDayForcast ?? [], id: \.dt) { forcastItem in
            ForecastItemView(forcastItem: forcastItem)
          }
        }
      }
    }
    .onAppear {
      vm.fetchForecast(for: locationService.lastLocation)
    }
  }
}
