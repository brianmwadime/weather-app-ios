//
//  Current.swift
//  Weather
//
//  Created by Brian Mwakima on 12/31/22.
//

import Foundation

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
  }
}

extension Current {
  /// Clouds object
  struct Clouds: Codable {
    let all: Int
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
      main: Main(
        temp: 0,
        feels_like: 0,
        temp_min: 0,
        temp_max: 0,
        pressure: 0,
        humidity: 0,
        sea_level: 0,
        grnd_level: 0),
      rain: nil,
      wind: Wind(
        speed: 0,
        deg: 0,
        gust: 0),
      clouds: Clouds(all: 0),
      timezone: 0)
  }
}
