//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation
import CoreLocation
import SwiftUI

class CurrentViewModel: ObservableObject {
  @Published var current: Current? = nil
  @Published var error: Error?

  var condition: String {
    current?.condition ?? "sunny"
  }

  var backgroundColor: Color {
    Color(current?.condition ?? "sunny")
  }

  var timeZone: Double {
    current?.timezone ?? 0
  }

  var weather: Current.Weather? {
    current?.weather[safe: 0]
  }

  var temperature: Double {
    current?.main.temp ?? 0
  }

  var maxTemperature: Double {
    current?.main.temp_max ?? 0
  }

  var minTemperature: Double {
    current?.main.temp_min ?? 0
  }

  var feelsLike: Double {
    current?.main.feels_like ?? 0
  }

  var date: Date? {
    current?.date
  }

  private let weatherService: WeatherServiceProtocol
  let repository: RepositoryType?

  init(weatherService: WeatherServiceProtocol, repository: RepositoryType? = nil) {
    self.repository = repository
    self.weatherService = weatherService
  }

  func fetchCurrent(for location: CLLocation?) {

    if let result = repository?.fetchOne(CurrentWeather.self, predicate: nil) {
      switch result {
        case .success(let currentEntity):
          self.current = currentEntity?.toModel()
        case .failure(let error): break
      }
    }

    guard let coordinates = location?.coordinate else {return}
    let currentCoordinates = Current.Coordinates(
      lat: coordinates.latitude,
      lon: coordinates.longitude)
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

  private func saveToDatabase(_ current: Current) {
    guard let context = repository?.context else {return}
    if let currentEntity = current.toNSManagedObject(in: context) {
      do {
        try repository?.create(currentEntity)
      } catch {
        print("\(error.localizedDescription)")
      }
    }
  }
}
