//
//  Forecast.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation
import CoreData

/// Weather Forecast from openweathermap api
struct Forecast: Codable {
  let message: Int
  /// List of `Current` for the weather forecast
  let list: [Current]

  /// Returns a five day forcast parsed from the `list` of 3 hour intervals  `Current` object.
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

  /// Returns an empty instance
  static func empty() -> Self {
    return Forecast(
      message: 0,
      list: [])
  }
}

extension Forecast: NSManagedObjectConvertible {
  func toNSManagedObject(in context: NSManagedObjectContext) -> WeatherForecast? {
    let entityDescription = WeatherForecast.entity()

    let forecastEntity = WeatherForecast(entity: entityDescription, insertInto: context)

    for current in self.list {

      if let currentEntity = current.toNSManagedObject(in: context) {
        forecastEntity.addToList(currentEntity)
      }
    }

    forecastEntity.lastUpdated = Date.now

    return forecastEntity
  }
}
