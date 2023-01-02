//
//  ConditionType.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

struct ConditionType {
  static func classifyCondition(by: Int) -> Condition {
    switch by {
      case Ranges.rain:
        return .rainy
      case Ranges.cloudy:
        return .partlysunny
      case Ranges.clear:
        return .clear
      default:
        return .clear
    }
  }

  enum Ranges {
    static let clear  = 800
    static let rain   = 200...531
    static let cloudy = 801...899
  }

  enum Condition: String {
    case clear
    case partlysunny
    case rainy
  }
}
