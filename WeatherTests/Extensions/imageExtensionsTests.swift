//
//  imageExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/19/23.
//

import XCTest
import SwiftUI
@testable import Weather

final class imageExtensionsTests: XCTestCase {

  func test_Image_iconFor_returns_nil() {

    let sut = Image.iconFor(condition: "blabla")

    XCTAssertNil(sut)

  }

  func test_Image_backgroundFor_returns_nil() {

    let sut = Image.backgroundFor(condition: "blabla")

    XCTAssertNil(sut)

  }

  func test_Image_iconFor_returns_Image() {

    let sut = Image.iconFor(condition: "sunny")

    XCTAssertNotNil(sut)
  }

  func test_Image_backgroundFor_returns_Image() {

    let sut = Image.backgroundFor(condition: "sunny")

    XCTAssertNotNil(sut)
  }

  func test_Image_iconFor_returns_rainy_Image() {

    let sut = Image.iconFor(condition: "rainy")

    XCTAssertNotNil(sut)
  }

  func test_Image_backgroundFor_returns_rainy_Image() {

    let sut = Image.backgroundFor(condition: "rainy")

    XCTAssertNotNil(sut)
  }

  func test_Image_iconFor_returns_cloudy_Image() {

    let sut = Image.iconFor(condition: "cloudy")

    XCTAssertNotNil(sut)
  }

  func test_Image_backgroundFor_returns_cloudy_Image() {

    let sut = Image.backgroundFor(condition: "cloudy")

    XCTAssertNotNil(sut)
  }

}
