//
//  CurrentViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 12/31/22.
//
import XCTest
import Combine
@testable import Weather
import SwiftUI

final class CurrentViewModelTests: XCTestCase {

  var sut: CurrentViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  var mockWeatherService: MockWeatherService!
  var currentRepository: MockCoreDataRepository!

  override func setUpWithError() throws {
    try super.setUpWithError()
    mockWeatherService = MockWeatherService()
    currentRepository = MockCoreDataRepository()
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

  func test_CurrentViewModel_props_should_be_default() {

    let expectation = XCTestExpectation(description: "current should be nil")

    sut?.$current
      .sink { currentValue in
        XCTAssertEqual(self.sut?.backgroundColor, Color("sunny"))
        XCTAssertEqual(self.sut?.condition, "sunny")
        XCTAssertEqual(self.sut?.timeZone, 0)
        XCTAssertEqual(self.sut?.temperature, 0)
        XCTAssertEqual(self.sut?.maxTemperature, 0)
        XCTAssertEqual(self.sut?.minTemperature, 0)
        XCTAssertEqual(self.sut?.feelsLike, nil)
        XCTAssertEqual(self.sut?.date, nil)
        XCTAssertEqual(self.sut?.lastUpdated, nil)
        XCTAssertNil(self.sut?.weather)
        expectation.fulfill()
      }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_CurrentViewModel_should_fetch_Current() {
    mockWeatherService.currentResult = .success(WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates()))

    sut?.fetchCurrent(for: WeatherFactory.createCLLocation())

    XCTAssertNotNil(sut?.current)
  }

  func test_CurrentViewModel_should_fetch_Error() {
    mockWeatherService.currentResult = .failure(WeatherFactory.createError())
    sut?.fetchCurrent(for: WeatherFactory.createCLLocation())

    XCTAssertNotNil(sut?.error)
  }

  func test_CurrentViewModel_has_props() {
    mockWeatherService.currentResult = .success(WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates()))

    sut?.fetchCurrent(for: WeatherFactory.createCLLocation())

    XCTAssertNotNil(sut?.backgroundColor)
    XCTAssertNotNil(sut?.condition)
    XCTAssertNotNil(sut?.timeZone)
    XCTAssertNotNil(sut?.temperature)
    XCTAssertNotNil(sut?.maxTemperature)
    XCTAssertNotNil(sut?.minTemperature)
    XCTAssertNotNil(sut?.feelsLike)
    XCTAssertNotNil(sut?.date)
    XCTAssertNil(sut?.lastUpdated)
    XCTAssertNotNil(sut?.weather)
  }

}
