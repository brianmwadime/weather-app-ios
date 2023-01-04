//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation
import CoreLocation

class ForecastViewModel: ObservableObject {
  @Published var forecast: Forecast? = nil
  @Published var error: Error?
  private let weatherService: WeatherServiceProtocol

  init(weatherService: WeatherServiceProtocol) {
    self.weatherService = weatherService
  }

  func fetchForecast(for location: CLLocation?) {
    guard let coordinates = location?.coordinate else {return}
    let currentCoordinates = Current.Coordinates(
      lat: coordinates.latitude,
      lon: coordinates.latitude)
    weatherService.fetchForecast(coordinates: currentCoordinates) { result in
      switch result {
        case .success(let forecast):
            self.forecast = forecast
        case .failure(let error):
            self.error = error
      }

    }
  }
}
