//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

class ForecastViewModel: ObservableObject {
  @Published var forecast: Forecast? = nil
  @Published var error: Error?
  private let weatherService: WeatherServiceProtocol

  init(weatherService: WeatherServiceProtocol) {
    self.weatherService = weatherService
  }

  func fetchForecast(for coordinates: Current.Coordinates) {
    weatherService.fetchForecast(coordinates: coordinates) { result in
      switch result {
        case .success(let forecast):
            self.forecast = forecast
        case .failure(let error):
            self.error = error
      }

    }
  }
}
