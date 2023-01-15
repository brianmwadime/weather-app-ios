//
//  WeatherEnvironment.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import SwiftUI

private struct AppBackgroundColorKey: EnvironmentKey {
  static let defaultValue: Binding<Color> = .constant(Color("sunny"))
}

extension EnvironmentValues {
  var appBackgroundColor: Binding<Color> {
    get { self[AppBackgroundColorKey.self] }
    set { self[AppBackgroundColorKey.self] = newValue }
  }
}
