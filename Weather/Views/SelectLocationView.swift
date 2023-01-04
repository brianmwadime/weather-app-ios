//
//  SelectLocationView.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import SwiftUI

struct SelectLocationContent: View {
  @EnvironmentObject var locationService: LocationService
  var action: () -> Void
  var body: some View {
    VStack {
      WelcomeView()
      if locationService.status != .available {
        Button("go_settings".localized()) {
          self.action()
        }
        .padding()
        .background(Color.green)
        .cornerRadius(10)
      }
    }
  }
}
