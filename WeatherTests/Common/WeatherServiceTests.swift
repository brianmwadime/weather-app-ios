//
//  WeatherServiceTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/3/23.
//

import XCTest
@testable import Weather

final class WeatherServiceTests: XCTestCase {

  func test_WeatherService_should_fetch_successCurrentResponse() {
    let expectation = self.expectation(description: "Should return correct Current data")
    let expectedResponseData = WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates())

    let sut = WeatherService(network: MockNetworkService(data: expectedResponseData.encode(), error: nil))

    sut.fetchCurrent(coordinates: WeatherFactory.createNairobiCoordinates()) { result in
      guard let responseData = try? result.get() else {
        XCTFail("Should return Current repsonse")
        return
      }

      XCTAssertEqual(responseData, expectedResponseData)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 0.1)
  }

  func test_WeatherService_should_fetch_successForecastResponse() {
    let expectation = self.expectation(description: "Should return correct Forecast data")
    let expectedResponseData = WeatherFactory.createForecast(with: WeatherFactory.createNairobiCoordinates())

    let sut = WeatherService(network: MockNetworkService(data: expectedResponseData.encode(), error: nil))

    sut.fetchForecast(coordinates: WeatherFactory.createNairobiCoordinates()) { result in
      guard let responseData = try? result.get() else {
        XCTFail("Should return Forecast repsonse")
        return
      }

      XCTAssertEqual(responseData, expectedResponseData)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 0.1)
  }
}

extension Current {
  func encode() -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(self)
  }
}

extension Forecast: Equatable {
  public static func == (lhs: Forecast, rhs: Forecast) -> Bool {
    return lhs.encode() == rhs.encode()
  }

  func encode() -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(self)
  }
}
