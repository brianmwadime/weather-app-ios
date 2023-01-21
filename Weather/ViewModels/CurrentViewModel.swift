//
//  CurrentViewModel.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//
import Foundation
import CoreLocation
import SwiftUI

final class CurrentViewModel: ObservableObject {
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

  var lastUpdated: Date? {
    current?.lastUpdated
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

  var feelsLike: Double? {
    current?.main.feels_like
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
        case .failure(let error):
          print("\(error.localizedDescription)")
      }
    }

    guard let coordinates = location?.coordinate else {return}
    let currentCoordinates = Current.Coordinates(
      lat: coordinates.latitude,
      lon: coordinates.longitude)
    let params = [
      "lat": "\(coordinates.latitude)",
      "lon": "\(coordinates.latitude)",
      "appid": Constants.openWeatherMapApi,
      "units": Constants.UnitsType.getUnitsName(by: UserDefaults.standard.integer(forKey: "units"))
    ]
    weatherService.fetchCurrent(params: params) { result in
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
    do {
      try repository?.deleteAll(CurrentWeather.fetchRequest())

      guard let context = repository?.context else {return}
      try repository?.create(current.toNSManagedObject(in: context))
    } catch {
      #if DEBUG
        print("\(error.localizedDescription)")
      #endif
    }
  }
}
