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
        if vm.error != nil {
          VStack(alignment: .center) {
            Spacer()
            Text("no_forecast".localized())
              .foregroundColor(Color.white)
              .multilineTextAlignment(.center)
            Spacer()
          }
          .frame(maxHeight: .infinity)
        }
        if vm.error == nil {
          VStack(alignment: .center, spacing: 8.0) {
            ForEach(vm.fiveDayForcast, id: \.dt) { forcastItem in
              ForecastItemView(forcastItem: forcastItem)
            }
          }
        }
      }
    }
    .frame(maxHeight: .infinity)
    .onAppear {
      vm.fetchForecast(for: locationService.lastLocation)
    }
  }
}
