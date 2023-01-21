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

    let params = buildParams(
      lat: WeatherFactory.createNairobiCoordinates().lat,
      lon: WeatherFactory.createNairobiCoordinates().lon)

    sut.fetchCurrent(params: params) { result in

      do {
        let responseData = try result.get()
        XCTAssertEqual(responseData, expectedResponseData)
        expectation.fulfill()
      } catch {
        XCTFail("Should return Current repsonse: \(error.localizedDescription)")
      }
    }

    wait(for: [expectation], timeout: 0.1)
  }

  func test_WeatherService_should_fetch_successForecastResponse() {
    let expectation = self.expectation(description: "Should return correct Forecast data")
    let expectedResponseData = WeatherFactory.createForecast(with: WeatherFactory.createNairobiCoordinates())

    let sut = WeatherService(network: MockNetworkService(data: expectedResponseData.encode(), error: nil))

    let params = buildParams(
      lat: WeatherFactory.createNairobiCoordinates().lat,
      lon: WeatherFactory.createNairobiCoordinates().lon)

    sut.fetchForecast(params: params) { result in
      do {
        let responseData = try result.get()
        XCTAssertEqual(responseData, expectedResponseData)
        expectation.fulfill()
      } catch {
        XCTFail("Should return Forecast repsonse: \(error.localizedDescription)")
      }
    }

    wait(for: [expectation], timeout: 0.1)
  }

  private func buildParams(lat: Double, lon: Double) -> [String: String?] {

    return [
      "lat": "\(lat)",
      "lon": "\(lon)"
    ]
  }
}

extension Current {
  func encode() -> Data? {
    let encoder = JSONEncoder()

    do {
      return try encoder.encode(self)
    } catch {

    }

    return  nil
  }
}

extension Forecast: Equatable {
  public static func == (lhs: Forecast, rhs: Forecast) -> Bool {
    return lhs.encode() == rhs.encode()
  }

  func encode() -> Data? {
    let encoder = JSONEncoder()
    do {
      return try encoder.encode(self)
    } catch {

    }

    return  nil
  }
}
