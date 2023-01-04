//
//  ConditionTypeTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/3/23.
//

import XCTest
@testable import Weather

final class ConditionTypeTests: XCTestCase {

  func test_ConditionType_is_Clear() {
    let condition = ConditionType.Condition.sunny

    XCTAssertEqual(ConditionType.classifyCondition(by: 800), condition)
  }

  func test_ConditionType_is_Rainy() {
    let condition = ConditionType.Condition.rainy

    XCTAssertEqual(ConditionType.classifyCondition(by: 500), condition)
  }

  func test_ConditionType_is_Cloudy() {
    let condition = ConditionType.Condition.cloudy

    XCTAssertEqual(ConditionType.classifyCondition(by: 820), condition)
  }

  func test_ConditionType_is_Default() {
    let condition = ConditionType.Condition.sunny

    XCTAssertEqual(ConditionType.classifyCondition(by: 700), condition)
  }
}
