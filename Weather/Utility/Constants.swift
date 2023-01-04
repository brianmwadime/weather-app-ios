//
//  Constants.swift
//  Weather
//
//  Created by Brian Mwakima on 12/31/22.
//

import Foundation

enum Constants {
  /// The base URL for the open openweathermap api
  static var baseURL: String { // forcast or weather ? lat & lon & appid & lang
    return "https://api.openweathermap.org/data/2.5/"
  }

  /// The openweathermap api ley
  static var openWeatherMapApi: String {
    return "e9e69bbebd860dd3da4fac154290bf58"
  }

  /// Unit type for setting measurement system to be used
  enum UnitsType: String {
    case standard
    case metric
    case imperial
  }


}
