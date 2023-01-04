//
//  CurrentView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation
import SwiftUI
import CoreData

struct CurrentView: View {
  @ObservedObject var vm: CurrentViewModel
  @EnvironmentObject var locationService: LocationService

  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        GeometryReader { geometry in
          Image("forest_\(vm.current?.condition ?? "sunny")")
            .resizable()
            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
            .frame(height: geometry.frame(in: .global).minY > 0 ? 320 + geometry.frame(in: .global).minY : 320)
        }
        .frame(height: 320)
        TemperatureView(main: vm.current?.main)
          .background(Color(vm.current?.condition ?? "sunny"))
      }
      .frame(maxWidth: .infinity)
      VStack {
        VStack(alignment: .trailing, spacing: 5) {
          Text("\(vm.current?.main.temp.roundDouble() ?? "0")°")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 50))
          Text(vm.current?.condition.uppercased() ?? "not_available".localized())
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 30))
        }
      }
    }
    .onAppear {
      vm.fetchCurrent(for: locationService.lastLocation)
    }
    .edgesIgnoringSafeArea(.top)
  }
}
