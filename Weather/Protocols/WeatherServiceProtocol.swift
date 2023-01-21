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
  ///
  /// - Parameters:
  ///  - params: `Dictionary` of parameters
  ///  - completion: Completion object with `Result<Current, Error>`
  func fetchCurrent(params: [String: String?], completion: @escaping (Result<Current, Error>) -> Void)

  /// Fetches  `Forecast` weather object
  /// 
  /// - Parameters:
  ///  - params: `Dictionary` of parameters
  ///  - completion: Completion object with `Result<Forecast, Error>`
  func fetchForecast(params: [String: String?], completion: @escaping (Result<Forecast, Error>)  -> Void)

  /// Build `URL` resource
  func buildURL(base: String, params: [String: String?]) -> URL?
}
