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
    try super.tearDownWithError()
  }

  func test_CurrentViewModel_should_exist() {

    XCTAssertNotNil(sut)
  }

  func test_CurrentViewModel_current_should_be_null() {

//    guard let current = try XCTUnwrap(sut?.current) else {
//      XCTFail("Could not get current")
//    }

    let expectation = XCTestExpectation(description: "Should be nil")

    sut?.$current.sink { currentValue in
      XCTAssertNil(currentValue)
      expectation.fulfill()
    }.store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }

  func test_CurrentViewModel_current_should_fetch_Current() {

    sut?.fetchCurrent(for: WeatherFactory.createNairobiCoordinates())

    XCTAssertNotNil(sut?.current)
  }

  func test_CurrentViewModel_current_should_fetch_Error() {
    mockWeatherService.currentResult = .failure(WeatherFactory.createError())
    sut?.fetchCurrent(for: WeatherFactory.createNairobiCoordinates())

    XCTAssertNotNil(sut?.error)
  }

}

class CurrentViewModel: ObservableObject {
  @Published var current: Current? = nil
  @Published var error: Error?
  private let weatherService: WeatherServiceProtocol

  init(weatherService: WeatherServiceProtocol) {
    self.weatherService = weatherService
  }

  func fetchCurrent(for coordinates: Current.Coordinates) {

    weatherService.fetchCurrent(coordinates: coordinates) { result in
      switch result {
        case .success(let current):
          self.current = current
        case .failure(let error):
          self.error = error
      }

    }
  }

}

protocol WeatherServiceProtocol: AnyObject {
  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void)
  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>)  -> Void)
}

final class MockWeatherService: WeatherServiceProtocol {
  var currentResult: Result<Current, Error> = .success(WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates()))
  var forcastResult: Result<Forecast, Error> = .success(WeatherFactory.createForecast(with: WeatherFactory.createNairobiCoordinates()))

  func fetchCurrent(coordinates: Weather.Current.Coordinates, completion: @escaping (Result<Weather.Current, Error>) -> Void) {
    completion(currentResult)
  }

  func fetchForecast(coordinates: Weather.Current.Coordinates, completion: @escaping (Result<Forecast, Error>) -> Void) {
    completion(forcastResult)
  }


}

struct WeatherFactory {
  static func createCurrent(with coordinates: Current.Coordinates) -> Current {
    return Current(coord: coordinates, weather: [createWeather()], main: createMain(), rain: createRain(), wind: createWind(), clouds: createClouds())
  }

  static func createForecast(with coordinates: Current.Coordinates) -> Forecast {
    return Forecast(message: 0, list: [createCurrent(with: createNairobiCoordinates())])
  }

  static func createNairobiCoordinates() -> Current.Coordinates {
    return Current.Coordinates(lat: 1.2921, lon: 36.8219)
  }

  static func createWeather() -> Current.Weather {
    return Current.Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
  }

  static func createMain() -> Current.Main {
    return Current.Main(temp: 298.48, feels_like: 298.74, temp_min: 297.56, temp_max: 300.05, pressure: 1015, humidity: 64, sea_level: 1015, grnd_level: 933)
  }

  static func createWind() -> Current.Wind {
    return Current.Wind(speed: 0.62, deg: 349, gust: 1.18)
  }

  static func createRain() -> Current.Rain {
    return Current.Rain(last1h: 3.16, last3h: nil)
  }

  static func createClouds() -> Current.Clouds {
    return Current.Clouds(all: 100)
  }

  static func createError() -> Error {
    return NSError(domain: "", code: -1)
  }
  
}
