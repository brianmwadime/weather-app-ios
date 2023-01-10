//
//  NSManagedObjectTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/10/23.
//

import XCTest
@testable import Weather

final class NSManagedObjectTests: XCTestCase {

  func test_NSManagedObject_to_model() throws {
    let context = getCoreDataContext()

    let sut = WeatherCurrent(context: context)
    sut.current = nil
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

extension WeatherCurrent: ModelConvertible {
  typealias ModelType = Current.Weather

  func toModel() -> Current.Weather? {
    return Current.Weather(id: 500, main: self.main ?? "", description: self.main_description ?? "", icon: self.icon ?? "")
  }
}


protocol ModelConvertible {
  /// The Model to convert to
  associatedtype ModelType

  /// converts a confroming instance to `ModelType` instance
  func toModel() -> ModelType?
}
