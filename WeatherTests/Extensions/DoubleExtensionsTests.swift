//
//  DoubleExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/1/23.
//
import XCTest
@testable import Weather

final class DoubleExtensionsTests: XCTestCase {

  func test_Double_roundDouble_to_String() {
    let value = 24.30
    XCTAssertEqual(value.roundDouble(), "24")
  }

}
