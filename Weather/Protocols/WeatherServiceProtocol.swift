//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation

/// A class for our weather service
protocol WeatherServiceProtocol: AnyObject {

  /// Fetches  `Current` weather object
  /// - Parameters:
  ///  - coordinates: `Current.Coordinates` for location
  ///  - completion: Completion object with `Result<Current, Error>`
  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void)

  /// Fetches  `Forecast` weather object
  /// - Parameters:
  ///  - coordinates: `Current.Coordinates` for location
  ///  - completion: Completion object with `Result<Forecast, Error>`
  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>)  -> Void)
}
