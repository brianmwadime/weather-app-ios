//
//  ImageExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/13/23.
//

import Foundation
import SwiftUI

extension Image {
  static func iconFor(condition: String) -> Image? {
    guard let condition = ConditionType.Condition(rawValue: condition) else {
      return nil
    }

    switch condition {
      case .sunny:
        return Image("sunny")
      case .rainy:
        return Image("rainy")
      case .cloudy:
        return Image("cloudy")
    }
  }

  static func backgroundFor(condition: String) -> Image? {
    guard let condition = ConditionType.Condition(rawValue: condition) else {
      return nil
    }

    switch condition {
      case .sunny:
        return Image("forest_sunny")
      case .rainy:
        return Image("forest_rainy")
      case .cloudy:
        return Image("forest_cloudy")
    }
  }
}
