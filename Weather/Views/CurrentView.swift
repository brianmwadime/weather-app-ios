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
  @EnvironmentObject var connectivity: Connectivity
  @Environment(\.appBackgroundColor) var appBackgroundColor

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        GeometryReader { geometry in
          Image.backgroundFor(condition: vm.condition)?
            .resizable()
            .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
            .frame(height: geometry.frame(in: .global).minY > 0 ? 320 + geometry.frame(in: .global).minY : 320)
        }
        .frame(height: 320)
        VStack(alignment: .center, spacing: 5) {
          Text(vm.temperature.roundDouble())
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 54))
          + Text("°")
            .foregroundColor(.white)
            .fontWeight(.thin)
            .font(.system(size: 64))
          Text(vm.condition.uppercased())
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 30))
          if let lastUpdated = vm.lastUpdated, !connectivity.isConnected {
            Text("last_updated \(lastUpdated.format(to: "dd/MM/YYYY hh:mm a"))")
              .foregroundColor(.white)
              .fontWeight(.regular)
              .font(.system(size: 14))
              .multilineTextAlignment(.center)
          }
        }
        .offset(y: -28)
      }
      TemperatureView(main: vm.current?.main)
    }
    .animation(Animation.easeInOut.speed(0.25), value: appBackgroundColor.wrappedValue)
    .edgesIgnoringSafeArea(.top)
  }
}
