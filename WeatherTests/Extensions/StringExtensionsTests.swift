//
//  StringExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/4/23.
//

import XCTest
@testable import Weather

final class StringExtensionsTests: XCTestCase {

  func test_String_is_localized() {
    let localized = "N/A"

    XCTAssertEqual(localized, "not_available".localized())
  }
}
