//
//  Current.swift
//  Weather
//
//  Created by Brian Mwakima on 12/31/22.
//

import Foundation

struct Current: Decodable {
  let dt: TimeInterval
  let coord: Coordinates?
  let weather: [Weather]
  let main: Main
  let rain: Rain?
  let wind: Wind
  let clouds: Clouds

  func getdayOfTheWeek() -> String {
    return Date(timeIntervalSince1970: dt).dayOfTheWeek
  }

  func getWeatherCondition() -> String {
    return ConditionType.classifyCondition(by: weather[0].id).rawValue
  }
}

extension Current: Equatable {
  static func == (lhs: Current, rhs: Current) -> Bool {
    return Date(timeIntervalSince1970: lhs.dt).dayOfTheWeek == Date(timeIntervalSince1970: rhs.dt).dayOfTheWeek
  }
}

extension Current {
  struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
  }
}

extension Current {
  struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
  }
}

extension Current {
  struct Rain: Decodable {
    let last1h: Double?
    let last3h: Double?

    enum CodingKeys: String, CodingKey {
      case last1h = "1h"
      case last3h = "3h"
    }
  }
}

extension Current {
  struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
  }
}

extension Current {
  struct Clouds: Decodable {
    let all: Int
  }
}

extension Current {
  struct Main: Decodable {
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
