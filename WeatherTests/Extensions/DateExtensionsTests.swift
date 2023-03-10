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

  override class func setUp() {
    super.setUp()

    DateFormatter.shared.timeZone = TimeZone(secondsFromGMT: 0)
  }

  func test_Date_get_dayOfTheWeek() {
    let date = Date(timeIntervalSince1970: 1553709600)
    XCTAssertEqual(date.dayOfTheWeek, "Wednesday")
  }

  func test_Date_format_hh_mm_a() {
    let date = Date(timeIntervalSince1970: 1553709600)
    let formattedDate = date.format()
    XCTAssertEqual(formattedDate, "06:00 PM")
  }

  func test_Date_format_with_offset_hh_mm_a() {
    let date = Date(timeIntervalSince1970: 1553709600)
    let formattedDate = date.format(with: 3600)
    XCTAssertEqual(formattedDate, "07:00 PM")
  }
}
