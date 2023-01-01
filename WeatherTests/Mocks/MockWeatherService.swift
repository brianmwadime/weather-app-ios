//
//  MockWeatherService.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation
@testable import Weather

final class MockWeatherService: WeatherServiceProtocol {
  var currentResult: Result<Current, Error> = .success(WeatherFactory.createCurrent(with: WeatherFactory.createNairobiCoordinates()))
  var forecastResult: Result<Forecast, Error> = .success(WeatherFactory.createForecast(with: WeatherFactory.createNairobiCoordinates()))

  func fetchCurrent(coordinates: Weather.Current.Coordinates, completion: @escaping (Result<Weather.Current, Error>) -> Void) {
    completion(currentResult)
  }

  func fetchForecast(coordinates: Weather.Current.Coordinates, completion: @escaping (Result<Forecast, Error>) -> Void) {
    completion(forecastResult)
  }
}
