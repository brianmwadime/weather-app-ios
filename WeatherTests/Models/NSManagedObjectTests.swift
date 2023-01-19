//
//  NSManagedObjectTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/10/23.
//

import XCTest
@testable import Weather

final class NSManagedObjectTests: XCTestCase {

  func test_NSManagedObject_to_model() {
    let context = getCoreDataContext()

    let sut = WeatherCurrent(context: context)
    sut.weather_id = 500
    sut.main_description = "Sunny Outside"
    sut.icon = ":-)"
    sut.main = "Sunny"

    do {
      try context.save()
      let model = sut.toModel()

      XCTAssertNotNil(model)

      XCTAssert((model as Any) is Current.Weather)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
}
