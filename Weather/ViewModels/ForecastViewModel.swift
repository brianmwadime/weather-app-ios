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

  var fiveDayForcast: [Current] {
    forecast?.fiveDayForcast ?? []
  }

  private let weatherService: WeatherServiceProtocol
  let repository: RepositoryType?

  init(weatherService: WeatherServiceProtocol, repository: RepositoryType? = nil) {
    self.repository = repository
    self.weatherService = weatherService
  }

  func fetchForecast(for location: CLLocation?) {
    if let result = repository?.fetchOne(WeatherForecast.self, predicate: nil) {
      switch result {
        case .success(let forecastEntity):
          self.forecast = forecastEntity?.toModel()
        case .failure(let error): break
      }
    }

    guard let coordinates = location?.coordinate else {return}
    let currentCoordinates = Current.Coordinates(
      lat: coordinates.latitude,
      lon: coordinates.longitude)
    weatherService.fetchForecast(coordinates: currentCoordinates) { result in
      switch result {
        case .success(let forecast):
          self.saveToDatabase(forecast)
          self.forecast = forecast
          self.error = nil
        case .failure(let error):
          self.error = error
      }
    }
  }

  private func saveToDatabase(_ forecast: Forecast) {
    guard let context = repository?.context else {return}
    if let forecastEntity = forecast.toNSManagedObject(in: context) {
      do {
        try repository?.create(forecastEntity)
      } catch {
        print("\(error.localizedDescription)")
      }
    }
  }
}
