//
//  CurrentTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/30/22.
//

import XCTest

class CurrentTests: XCTestCase {

  private lazy var current: Current = {
    return try! mapCurrent(from: "current")
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
    XCTAssertEqual(current.coord.lat, 10.99)

  }

  func test_current_has_Weather() {
    
  }

}

struct Current: Decodable {
  let coord: Coordinates
}

extension Current {
  struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
  }
}

private extension CurrentTests {

  func mapCurrent(from filename: String) throws -> Current {
    let response = Loader.contentsOf(filename)!

    let decoder = JSONDecoder()

    return try decoder.decode(Current.self, from: response)
  }

}
