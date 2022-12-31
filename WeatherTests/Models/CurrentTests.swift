//
//  CurrentTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/30/22.
//

import XCTest
import Foundation

class CurrentTests: XCTestCase {

  private lazy var current: Current = {
    return try! mapCurrent(from: "current") // swiftlint:disable:this force_try
  }()

  func test_current_has_coords() {
    XCTAssertNotNil(current.coord)
  }

  func test_currentCoord_has_lat_lon() {
    XCTAssertNotNil(current.coord.lat)
    XCTAssertNotNil(current.coord.lon)
  }

  func test_currentCoord_has_double_lat_lon() {
    XCTAssertEqual(current.coord.lat, 44.34)
    XCTAssertEqual(current.coord.lon, 10.99)

  }

  func test_current_has_weather_array() {
    XCTAssert((current.weather as Any) is [Current.Weather])
  }

  func test_currentWeatherArray_has_weather_items() {

    for weather in current.weather {
      XCTAssertNotNil(weather.id)
      XCTAssertNotNil(weather.main)
      XCTAssertNotNil(weather.description)
      XCTAssertNotNil(weather.icon)
    }
  }

  func test_current_has_main() {
    XCTAssertNotNil(current.main)
  }

  func test_currentMain_has_props() {
    XCTAssertNotNil(current.main.temp)
    XCTAssertNotNil(current.main.feels_like)
    XCTAssertNotNil(current.main.temp_min)
    XCTAssertNotNil(current.main.temp_max)
    XCTAssertNotNil(current.main.pressure)
    XCTAssertNotNil(current.main.humidity)
    XCTAssertNotNil(current.main.sea_level)
    XCTAssertNotNil(current.main.grnd_level)
  }

  func test_current_has_wind() {
    XCTAssertNotNil(current.wind)
  }

  func test_currentWind_has_props() {
    XCTAssertNotNil(current.wind.speed)
    XCTAssertNotNil(current.wind.deg)
    XCTAssertNotNil(current.wind.gust)
  }

  func test_current_has_rain() {
    XCTAssertNotNil(current.rain)
  }

  func test_currentRain_has_props() {
    XCTAssertNotNil(current.rain.last1h)
    XCTAssertNil(current.rain.last3h)
  }

  func test_current_has_clouds() {
    XCTAssertNotNil(current.clouds)
  }

  func test_currentClouds_has_props() {
    XCTAssertNotNil(current.clouds.all)
  }
}

struct Current: Decodable {
  let coord: Coordinates
  let weather: [Weather]
  let main: Main
  let rain: Rain
  let wind: Wind
  let clouds: Clouds
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

    private enum CodingKeys: String, CodingKey {
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

private extension CurrentTests {

  func mapCurrent(from filename: String) throws -> Current {
    let response = Loader.contentsOf(filename)!

    let decoder = JSONDecoder()

    return try decoder.decode(Current.self, from: response)
  }

}
