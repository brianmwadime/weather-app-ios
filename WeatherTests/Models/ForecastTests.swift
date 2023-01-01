//
//  ForcastTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/31/22.
//

import XCTest
@testable import Weather

final class ForecastTests: XCTestCase {

  private lazy var forecast: Forecast = {
    return try! mapForecast(from: "forecast5") // swiftlint:disable:this force_try
  }()

  func test_forecast_has_message() {
    XCTAssertNotNil(forecast.message)
    XCTAssertEqual(forecast.message, 0)
  }

  func test_forecast_contains_Current_list() {
    XCTAssertNotNil(forecast.list)
  }

  func test_forecast_has_Current_array() {
    XCTAssert((forecast.list as Any) is [Current])
  }

  func test_forecast_has_5_Current_items_in_array() {
    XCTAssertEqual(forecast.list.count, 5)
  }
}

private extension ForecastTests {

  func mapForecast(from filename: String) throws -> Forecast {
    let response = Loader.contentsOf(filename)!

    let decoder = JSONDecoder()

    return try decoder.decode(Forecast.self, from: response)
  }
}
