//
//  LocationsViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/4/23.
//

import XCTest
import Combine
@testable import Weather

final class LocationsViewModelTests: XCTestCase {

  var sut: LocationsViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

  override func setUpWithError() throws {
    sut = LocationsViewModel()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_LocationsViewModel_locations_should_be_empty() {

    let expectation = XCTestExpectation(description: "Should be empty")

    sut?.$locations.sink { currentValue in
      XCTAssertEqual(currentValue.count, 0)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationsViewModel_isSearching_should_be_false() {

    let expectation = XCTestExpectation(description: "Should be false")

    sut?.$isSearching.sink { currentValue in
      XCTAssertEqual(currentValue, false)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_LocationsViewModel_searchFor_should_be_called() {

    let searchTerm = "Nairobi"

    sut?.search(for: searchTerm)

    XCTAssertEqual(sut?.completer.queryFragment, searchTerm)
  }

  func test_LocationsViewModel_clearResults_should_remove_locations() {
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
