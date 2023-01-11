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

extension Forecast: NSManagedObjectConvertible {
  typealias ObjectType = CurrentWeather

  func toNSManagedObject(in context: NSManagedObjectContext) -> CurrentWeather? {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: "Current", in: context) else {
      NSLog("Can't create entity Current")
      return nil
    }

    let object = CurrentWeather(entity: entityDescription, insertInto: context)

    if let timezone = timezone {
      object.timezone = timezone
    }

    guard let weatherDescription = NSEntityDescription.entity(forEntityName: "Weather", in: context) else {
      NSLog("Can't create entity Weather")
      return nil
    }

    for weather in self.weather {

      let weatherEntity = WeatherCurrent(entity: weatherDescription, insertInto: context)
      weatherEntity.main = weather.main
      weatherEntity.icon = weather.icon
      weatherEntity.main_description = weather.description
      weatherEntity.current = object
      object.addToWeather(weatherEntity)
    }

    guard let mainDescription = NSEntityDescription.entity(forEntityName: "Main", in: context) else {
      NSLog("Can't create entity Main")
      return nil
    }

    let mainEntity = MainCurrent(entity: mainDescription, insertInto: context)
    mainEntity.temp = main.temp
    mainEntity.feels_like = main.feels_like
    mainEntity.temp_min = main.temp_min
    mainEntity.temp_max = main.temp_max
    mainEntity.pressure = Double(main.pressure)

    object.main = mainEntity
    object.dt = dt

    return object
  }
}
