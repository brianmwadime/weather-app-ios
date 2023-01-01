//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void)
  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>)  -> Void)
}
