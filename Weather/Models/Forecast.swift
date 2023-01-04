//
//  Forecast.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

/// Weather Forecast from openweathermap api
struct Forecast: Codable {
  let message: Int
  /// List of `Current` for the weather forecast
  let list: [Current]

  var fiveDayForcast: [Current] {
    var result: [Current] = []
    guard var before = list.first else {
      return result
    }

    if before.dayOfTheWeek != Date().dayOfTheWeek {
      result.append(before)
    }

    for forcast in list {
      if forcast.dayOfTheWeek != before.dayOfTheWeek {
        result.append(forcast)
      }
      before = forcast
    }

    return result
  }
}
