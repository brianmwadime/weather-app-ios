//
//  DateExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

import XCTest
@testable import Weather

final class DateExtensionsTests: XCTestCase {

  func test_Date_get_dayOfTheWeek() {
    let date = Date(timeIntervalSince1970: 1553709600)
    XCTAssertEqual(date.dayOfTheWeek, "Wednesday")
  }

}
