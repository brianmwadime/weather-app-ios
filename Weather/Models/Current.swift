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
}

extension Current: Equatable {
  static func == (lhs: Current, rhs: Current) -> Bool {
    return Date(timeIntervalSince1970: lhs.dt).dayOfTheWeek == Date(timeIntervalSince1970: rhs.dt).dayOfTheWeek
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

    enum CodingKeys: String, CodingKey {
      case last1h = "1h"
      case last3h = "3h"
    }
  }
}

extension Current {
  /// Wind object
  struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double

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
    let sea_level: Int
    let grnd_level: Int

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
      timezone: 0)
  }
}

extension Current: NSManagedObjectConvertible {
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

extension CurrentWeather: ModelConvertible {
  typealias ModelType = Current

  func toModel() -> Current? {
    let weathers = self.weather.array(of: WeatherCurrent.self)

    var weatherArray: [Current.Weather] = []

    for weather in weathers {
      weatherArray.append(
        weather.toModel()!
      )
    }

    return Current(
      dt: self.dt,
      coord: nil,
      weather: weatherArray,
      main: self.main.toModel()!,
      rain: nil,
      wind: Current.Wind.empty(),
      clouds: Current.Clouds.empty(),
      timezone: self.timezone)
  }
}

extension WeatherCurrent: ModelConvertible {
  typealias ModelType = Current.Weather

  func toModel() -> Current.Weather? {
    return Current.Weather(
      id: Int(self.weather_id),
      main: self.main,
      description: self.main_description,
      icon: self.icon)
  }
}

extension MainCurrent: ModelConvertible {
  typealias ModelType = Current.Main

  func toModel() -> Current.Main? {
    return Current.Main(
      temp: self.temp,
      feels_like: self.feels_like,
      temp_min: self.temp_min,
      temp_max: self.temp_max,
      pressure: Int(self.pressure),
      humidity: Int(self.humidity),
      sea_level: 0,
      grnd_level: 0)
  }
}
