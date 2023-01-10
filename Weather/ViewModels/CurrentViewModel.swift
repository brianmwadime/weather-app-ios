//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation
import CoreLocation

class CurrentViewModel: ObservableObject {
  @Published var current: Current = Current.empty()
  @Published var error: Error?

  var condition: String {
    current.condition
  }

  var timeZone: Double {
    current.timezone ?? 0
  }

  private let weatherService: WeatherServiceProtocol
  let repository: RepositoryType?

  init(weatherService: WeatherServiceProtocol, repository: RepositoryType? = nil) {
    self.repository = repository
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
          self.saveToDatabase(current)
          self.current = current
          self.error = nil
        case .failure(let error):
            self.error = error
      }
    }
  }

  func saveToDatabase(_ current: Current) {
    guard let context = repository?.context else {return}
    if let currentEntity = current.toNSManagedObject(in: context) {
      do {
        try repository?.create(currentEntity)
      } catch {

      }
    }
  }
}
