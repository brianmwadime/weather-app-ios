//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation

class CurrentViewModel: ObservableObject {
  @Published var current: Current? = nil
  @Published var error: Error?
  private let weatherService: WeatherServiceProtocol

  init(weatherService: WeatherServiceProtocol) {
    self.weatherService = weatherService
  }

  func fetchCurrent(for coordinates: Current.Coordinates) {

    weatherService.fetchCurrent(coordinates: coordinates) { result in
      switch result {
        case .success(let current):
          self.current = current
        case .failure(let error):
          self.error = error
      }

    }
  }

}
