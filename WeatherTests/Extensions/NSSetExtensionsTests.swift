//
//  NSSetExtensionsTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/19/23.
//

import XCTest
import Foundation
@testable import Weather

final class NSSetExtensionsTests: XCTestCase {

    func test_NSSet_returns_array() {
      let sut: NSSet? = NSSet(array: [1, 2, 3, 4])

      XCTAssertNotNil(sut.array(of: Int.self))
    }

    func test_NSSet_returns_empty_array() {
      let sut: NSSet? = nil

      XCTAssert(sut.array(of: Int.self).isEmpty)
    }
}
