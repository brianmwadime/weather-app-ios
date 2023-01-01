//
//  WeatherService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation


final class WeatherService: WeatherServiceProtocol {
  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void) {
    let request = URLRequest(url: URL(string: Constants.baseURL))
  }

  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>) -> Void) {

  }


}
