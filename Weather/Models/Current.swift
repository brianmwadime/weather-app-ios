//
//  Current.swift
//  Weather
//
//  Created by Brian Mwakima on 12/31/22.
//

import Foundation
import CoreData

/// Weather details object from openweathermap api
struct Current: Codable {
  let dt: TimeInterval
  let coord: Coordinates?
  let weather: [Weather]
  let main: Main
  let rain: Rain?
  let wind: Wind
  let clouds: Clouds
  /// Day of the week from `dt` property
  var dayOfTheWeek: String { Date(timeIntervalSince1970: dt).dayOfTheWeek }
  /// Day of the week from `Weather.id` property
  var condition: String { ConditionType.classifyCondition(by: weather[0].id).rawValue }
  /// Date object
  var date: Date { Date(timeIntervalSince1970: dt) }
  let timezone: Double?
  let lastUpdated: Date?
}

extension Current: Equatable {
  static func == (lhs: Current, rhs: Current) -> Bool {
    return lhs.date.dayOfTheWeek == rhs.date.dayOfTheWeek
  }
}

extension Current {
  /// Coordinates object
  struct Coordinates: Codable {
    let lat: Double
    let lon: Double
  }
}

extension Current {
  /// Weather object
  struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
  }
}

extension Current {
  /// Rain object
  struct Rain: Codable {
    let last1h: Double?
    let last3h: Double?
    /// Returns empty instance
    enum CodingKeys: String, CodingKey {
      case last1h = "1h"
      case last3h = "3h"
    }
  }
}

extension Current {
  /// Wind object
  struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    /// Returns empty instance
    static func empty() -> Self {
      return Wind(
        speed: 0,
        deg: 0,
        gust: 0)
    }
  }
}

extension Current {
  /// Clouds object
  struct Clouds: Codable {
    let all: Int
    /// Returns empty instance
    static func empty() -> Self {
      return Clouds(all: 0)
    }
  }
}

extension Current {
  /// Main object
  struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?

    /// Returns empty instance
    static func empty() -> Self {
      return Main(
        temp: 0,
        feels_like: 0,
        temp_min: 0,
        temp_max: 0,
        pressure: 0,
        humidity: 0,
        sea_level: 0,
        grnd_level: 0)
    }
  }
}

extension Current {
  /// Returns empty instance
  static func empty() -> Self {
    return Current(
      dt: 0,
      coord: nil,
      weather: [
        Weather(
          id: 0,
          main: "",
          description: "",
          icon: "")
      ],
      main: Main.empty(),
      rain: nil,
      wind: Wind.empty(),
      clouds: Clouds(all: 0),
      timezone: 0,
      lastUpdated: nil)
  }
}

extension Current: NSManagedObjectConvertible {
  func toNSManagedObject(in context: NSManagedObjectContext) -> CurrentWeather {
    let entityDescription = CurrentWeather.entity()

    let object = CurrentWeather(entity: entityDescription, insertInto: context)

    if let timezone = timezone {
      object.timezone = timezone
    }

    let weatherDescription = WeatherCurrent.entity()

    for weather in self.weather {

      let weatherEntity = WeatherCurrent(entity: weatherDescription, insertInto: context)
      weatherEntity.weather_id = Int16(weather.id)
      weatherEntity.main = weather.main
      weatherEntity.icon = weather.icon
      weatherEntity.main_description = weather.description
      object.addToWeather(weatherEntity)
    }

    let mainDescription = MainCurrent.entity()

    let mainEntity = MainCurrent(entity: mainDescription, insertInto: context)
    mainEntity.temp = main.temp
    mainEntity.feels_like = main.feels_like
    mainEntity.temp_min = main.temp_min
    mainEntity.temp_max = main.temp_max
    mainEntity.pressure = Double(main.pressure)

    object.main = mainEntity
    object.dt = Date(timeIntervalSince1970: dt)
    object.lastUpdated = Date.now

    return object
  }
}
