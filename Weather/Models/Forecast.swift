//
//  Forecast.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

/// Weather Forecast from openweathermap api
struct Forecast: Codable {
  let message: Int
  /// List of `Current` for the weather forecast
  let list: [Current]
}
