//
//  WeatherService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {

  let network: NetworkService

  init(network: NetworkService) {
    self.network = network
  }

  func fetchCurrent(params: [String: String?], completion: @escaping (Result<Current, Error>) -> Void) {

    guard let url = buildURL(base: Constants.baseURL + "weather", params: params) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }
    let request = URLRequest(url: url)
    network.execute(with: request, model: Current.self, completion: completion)
  }

  func fetchForecast(params: [String: String?], completion: @escaping (Result<Forecast, Error>) -> Void) {
    guard let url = buildURL(base: Constants.baseURL + "forecast", params: params) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }

    let request = URLRequest(url: url)
    network.execute(with: request, model: Forecast.self, completion: completion)
  }
}

extension WeatherService {
  func buildURL(base: String, params: [String: String?]) -> URL? {

    guard var urlComponents = URLComponents(string: base) else {
      return nil
    }

    var queryParams: [URLQueryItem] = []

    for param in params {
      queryParams.append(URLQueryItem(name: param.key, value: param.value))
    }

    urlComponents.queryItems = queryParams

    return urlComponents.url
  }
}
