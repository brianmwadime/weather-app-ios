//
//  CurrentViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/31/22.
//
import XCTest
import Combine
@testable import Weather

final class CurrentViewModelTests: XCTestCase {

  var sut: CurrentViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  var mockWeatherService: MockWeatherService!

  override func setUpWithError() throws {
    try super.setUpWithError()
    mockWeatherService = MockWeatherService()
    sut = CurrentViewModel(weatherService: mockWeatherService)
  }

  override func tearDownWithError() throws {
    sut = nil
    mockWeatherService = nil
    try super.tearDownWithError()
  }

  func test_CurrentViewModel_should_exist() {

    XCTAssertNotNil(sut)
  }

  func test_CurrentViewModel_current_should_be_nil() {

    let expectation = XCTestExpectation(description: "current should be nil")

    sut?.$current
      .sink { currentValue in
        XCTAssertNil(currentValue)
        expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_CurrentViewModel_should_fetch_Current() {
    mockWeatherService.currentResult = .success(WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates()))

    sut?.fetchCurrent(for: WeatherFactory.createNairobiCoordinates())

    XCTAssertNotNil(sut?.current)
  }

  func test_CurrentViewModel_should_fetch_Error() {
    mockWeatherService.currentResult = .failure(WeatherFactory.createError())
    sut?.fetchCurrent(for: WeatherFactory.createNairobiCoordinates())

    XCTAssertNotNil(sut?.error)
  }

}
