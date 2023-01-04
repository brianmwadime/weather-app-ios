//
//  CurrentTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/30/22.
//

import XCTest
import Foundation
@testable import Weather

class CurrentTests: XCTestCase {

  private lazy var current: Current = {
    return try! mapCurrent(from: "current") // swiftlint:disable:this force_try
  }()

  func test_current_has_coords() {
    XCTAssertNotNil(current.coord)
  }

  func test_current_has_dayOfTheWeek() {
    XCTAssertNotNil(current.dayOfTheWeek)
  }

  func test_current_has_condition() {
    XCTAssertNotNil(current.condition)
  }

  func test_currentCoord_has_lat_lon() throws {

    let coord = try XCTUnwrap(current.coord)

    XCTAssertNotNil(coord.lat)
    XCTAssertNotNil(coord.lon)
  }

  func test_currentCoord_has_double_lat_lon() throws {
    let coord = try XCTUnwrap(current.coord)

    XCTAssertEqual(coord.lat, 44.34)
    XCTAssertEqual(coord.lon, 10.99)

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

  func test_currentRain_has_props() throws {
    let rain = try XCTUnwrap(current.rain)
    XCTAssertNotNil(rain.last1h)
    XCTAssertNil(rain.last3h)
  }

  func test_current_has_clouds() {
    XCTAssertNotNil(current.clouds)
  }

  func test_currentClouds_has_props() {
    XCTAssertNotNil(current.clouds.all)
  }
}

private extension CurrentTests {

  func mapCurrent(from filename: String) throws -> Current {
    let response = Loader.contentsOf(filename)!

    let decoder = JSONDecoder()

    return try decoder.decode(Current.self, from: response)
  }

}
