//
//  WeatherService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

class WeatherService: WeatherServiceProtocol {

  let network: NetworkService

  init(network: NetworkService) {
    self.network = network
  }

  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void) {

    guard let url = buildURL(base: Constants.baseURL + "weather", coordinates: coordinates) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }
    let request = URLRequest(url: url)
    network.execute(with: request, model: Current.self, completion: completion)
  }

  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>) -> Void) {
    guard let url = buildURL(base: Constants.baseURL + "forecast", coordinates: coordinates) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }

    let request = URLRequest(url: url)
    network.execute(with: request, model: Forecast.self, completion: completion)
  }
}

extension WeatherService {
  private func buildURL(base: String, coordinates: Current.Coordinates) -> URL? {
    let queries = String(
      format: "lat=%.4f&lon=%.4f&appid=%@&units=%@",
      coordinates.lat,
      coordinates.lon,
      Constants.openWeatherMapApi,
      Constants.UnitsType.metric.rawValue)
    let urlString = "\(base)?\(queries)"

    return (URL(string: urlString))
  }
}
