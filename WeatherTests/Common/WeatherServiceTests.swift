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
      let expectation = self.expectation(description: "Should return correct data")
      let expectedResponseData = WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates())

      let sut = WeatherService(network: MockNetworkService(data: expectedResponseData.encodeCurrent(), error: nil))

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
}

extension Current {
  func encodeCurrent() -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(self)
  }
}
