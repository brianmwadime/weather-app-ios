//
//  ForecastListView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import SwiftUI

struct ForecastListView: View {
  @ObservedObject var vm: ForecastViewModel
  @EnvironmentObject var locationService: LocationService
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    ZStack {
      appBackgroundColor.wrappedValue
        .ignoresSafeArea(.all)
      VStack(spacing: 0) {
        Divider()
          .frame(height: 16)
          .overlay(appBackgroundColor.wrappedValue)

        switch (vm.error, vm.forecast) {
          case (.none, let forecast) where forecast != nil:
            VStack(alignment: .center, spacing: 8.0) {
              ForEach(vm.fiveDayForcast, id: \.dt) { forcastItem in
                ForecastItemView(forcastItem: forcastItem)
              }
            }
          case (.none, .none):
            VStack(alignment: .center) {
              Spacer()
              Text("no_forecast".localized())
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
              Spacer()
            }
            .frame(maxHeight: .infinity)
          case (let error, let forecast):
            if forecast?.list.isEmpty == false {
              VStack(alignment: .center, spacing: 8.0) {
                ForEach(vm.fiveDayForcast, id: \.dt) { forcastItem in
                  ForecastItemView(forcastItem: forcastItem)
                }
              }
            } else {
              VStack(alignment: .center) {
                Spacer()
                Text("no_forecast".localized())
                  .foregroundColor(Color.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .frame(maxHeight: .infinity)
            }

        }

//        if vm.error != nil {
//          VStack(alignment: .center) {
//            Spacer()
//            Text("no_forecast".localized())
//              .foregroundColor(Color.white)
//              .multilineTextAlignment(.center)
//            Spacer()
//          }
//          .frame(maxHeight: .infinity)
//        }

//        if vm.error == nil {
//          VStack(alignment: .center, spacing: 8.0) {
//            ForEach(vm.fiveDayForcast, id: \.dt) { forcastItem in
//              ForecastItemView(forcastItem: forcastItem)
//            }
//          }
//        }
      }
    }
    .animation(Animation.easeInOut.speed(0.25), value: appBackgroundColor.wrappedValue)
    .onChange(of: locationService.lastLocation, perform: { newValue in
      vm.fetchForecast(for: newValue)
    })
    .onAppear {
//      vm.fetchForecast(for: locationService.lastLocation)
    }
  }
}
