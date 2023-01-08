//
//  LocationSearchViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/4/23.
//

import XCTest
import Combine
@testable import Weather

final class LocationSearchViewModelTests: XCTestCase {

  var sut: LocationSearchViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  override func setUpWithError() throws {
    sut = LocationSearchViewModel()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_LocationSearchViewModel_locations_should_be_empty() {

    let expectation = XCTestExpectation(description: "Should be empty")

    sut?.$locations.sink { currentValue in
      XCTAssertEqual(currentValue.count, 0)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationSearchViewModel_isSearching_should_be_false() {

    let expectation = XCTestExpectation(description: "Should be false")

    sut?.$isSearching.sink { currentValue in
      XCTAssertEqual(currentValue, false)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationSearchViewModel_searchFor_should_be_called() {

    let searchTerm = "Nairobi"

    sut?.search(for: searchTerm)

    XCTAssertEqual(sut?.completer.queryFragment, searchTerm)
  }

  func test_LocationSearchViewModel_clearResults_should_remove_locations() {
    let searchTerm = "Nairobi"
    let expectation = XCTestExpectation(description: "Should be empty")

    sut?.search(for: searchTerm)

    sut?.$locations.sink { currentValue in
      XCTAssertEqual(currentValue.count, 0)
      expectation.fulfill()
    }.store(in: &cancellables)

    sut?.$isSearching.sink { currentValue in
      XCTAssertEqual(currentValue, false)
      expectation.fulfill()
    }.store(in: &cancellables)

    sut?.clearResults()

    wait(for: [expectation], timeout: 1)
  }
}
