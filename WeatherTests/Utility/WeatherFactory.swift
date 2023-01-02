//
//  WeatherFactory.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation
@testable import Weather

/// Factory for creating various model objects for testing purposes.
struct WeatherFactory {
  static func createCurrent(with coordinates: Current.Coordinates) -> Current {
    return Current(
      dt: 1553709600,
      coord: coordinates,
      weather: [createWeather()],
      main: createMain(),
      rain: createRain(), wind: createWind(), clouds: createClouds())
  }

  static func createForecast(with coordinates: Current.Coordinates) -> Forecast {
    return Forecast(
      message: 0,
      list: [
        createCurrent(with: createNairobiCoordinates()),
        createCurrent(with: createNairobiCoordinates()),
        createCurrent(with: createNairobiCoordinates()),
        createCurrent(with: createNairobiCoordinates()),
        createCurrent(with: createNairobiCoordinates()),
        createCurrent(with: createNairobiCoordinates())
      ])
  }

  static func createNairobiCoordinates() -> Current.Coordinates {
    return Current.Coordinates(lat: 1.2921, lon: 36.8219)
  }

  static func createWeather() -> Current.Weather {
    return Current.Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
  }

  static func createMain() -> Current.Main {
    return Current.Main(
      temp: 298.48,
      feels_like: 298.74,
      temp_min: 297.56,
      temp_max: 300.05,
      pressure: 1015,
      humidity: 64,
      sea_level: 1015,
      grnd_level: 933)
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
