//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation
import CoreLocation

class CurrentViewModel: ObservableObject {
  @Published var current: Current? = nil
  @Published var error: Error?
  private let weatherService: WeatherServiceProtocol

  init(weatherService: WeatherServiceProtocol) {
    self.weatherService = weatherService
  }

  func fetchCurrent(for location: CLLocation?) {
    guard let coordinates = location?.coordinate else {return}
    let currentCoordinates = Current.Coordinates(
      lat: coordinates.latitude,
      lon: coordinates.latitude)
    weatherService.fetchCurrent(coordinates: currentCoordinates) { result in
      switch result {
        case .success(let current):
            self.current = current
        case .failure(let error):
            self.error = error
      }
    }
  }
}
