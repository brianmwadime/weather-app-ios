//
//  ConditionType.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

/// Weather condition classification.
struct ConditionType {

  /// Returns weather `ConditionType.Condition`
  ///
  /// Get weather condition based on `ConditionType.Ranges` value
  /// - Parameters:
  ///  - by: A range value
  static func classifyCondition(by: Int) -> Condition {
    switch by {
      case Ranges.rain:
        return .rainy
      case Ranges.cloudy:
        return .cloudy
      case Ranges.clear:
        return .sunny
      default:
        return .sunny
    }
  }

  /// Weather condition ranges
  enum Ranges {
    static let clear  = 800
    static let rain   = 200...531
    static let cloudy = 801...899
  }

  /// Weather condition type
  enum Condition: String {
    case sunny
    case cloudy
    case rainy
  }
}
