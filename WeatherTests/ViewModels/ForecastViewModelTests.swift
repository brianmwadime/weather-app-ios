//
//  ForecastViewModelTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/1/23.
//
import XCTest
import Combine
@testable import Weather

final class ForecastViewModelTests: XCTestCase {

  var sut: ForecastViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  var mockWeatherService: MockWeatherService!

  override func setUpWithError() throws {
    try super.setUpWithError()
    mockWeatherService = MockWeatherService()
    sut = ForecastViewModel(weatherService: mockWeatherService)
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_ForecastViewModel_should_exist() {

    XCTAssertNotNil(sut)
  }

  func test_ForecastViewModel_forecast_should_be_nil() {

    let expectation = XCTestExpectation(description: "Should be nil")

    sut?.$forecast.sink { currentValue in
      XCTAssertNil(currentValue)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_ForecastViewModel_should_fetch_Forcast() {

    sut?.fetchForecast(for: WeatherFactory.createCLLocation())
    XCTAssertNotNil(sut?.forecast)
  }

  func test_ForecastViewModel_should_generate_5DayForcast() {

    sut?.fetchForecast(for: WeatherFactory.createCLLocation())
    XCTAssertNotNil(sut?.fiveDayForcast)
  }

  func test_ForecastViewModel_should_fetch_Error() {
    mockWeatherService.forecastResult = .failure(WeatherFactory.createError())
    sut?.fetchForecast(for: WeatherFactory.createCLLocation())

    XCTAssertNotNil(sut?.error)
  }
}
