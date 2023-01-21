//
//  WelcomeView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import SwiftUI

struct WelcomeView: View {
  @EnvironmentObject var locationService: LocationService

  var body: some View {
    VStack {
      VStack {
//        Image("LaunchIcon")
//          .resizable()
//          .scaledToFit()
//          .padding()
        Text("Weather")
          .font(.system(size: 28, weight: .bold, design: .rounded))
      }

      Text("enable_location".localized())
        .font(.title2)
        .padding(.top)
    }
  }
}
