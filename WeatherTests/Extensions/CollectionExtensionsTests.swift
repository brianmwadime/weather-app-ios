//
//  CollectionExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/19/23.
//

import XCTest
@testable import Weather

final class CollectionExtensionsTests: XCTestCase {

  func test_Collection_has_index_item() {

    let sut = [
      "Monday",
      "Tuesday"
    ]

    XCTAssertNotNil(sut[safe: 1])

  }

  func test_Collection_has_index_nil() {

    let sut = [
      "Monday",
      "Tuesday"
    ]

    XCTAssertNil(sut[safe: 3])

  }

}
