//
//  WeatherService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

final class WeatherService: WeatherServiceProtocol {
  func fetchCurrent(coordinates: Current.Coordinates, completion: @escaping (Result<Current, Error>) -> Void) {

    guard let url = buildURL(base: Constants.baseURL + "weather", coordinates: coordinates) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }
    let request = URLRequest(url: url)
    execute(with: request, model: Current.self, completion: completion)
  }

  func fetchForecast(coordinates: Current.Coordinates, completion: @escaping (Result<Forecast, Error>) -> Void) {
    guard let url = buildURL(base: Constants.baseURL + "forecast", coordinates: coordinates) else {
      return completion(.failure(NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))))
    }

    let request = URLRequest(url: url)
    execute(with: request, model: Forecast.self, completion: completion)
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

  private func execute<T: Decodable>(with request: URLRequest, model: T.Type,
                                   completion: @escaping(Result<T, Error>) -> Void) {

    URLSession.shared.dataTask(with: request) { data, response, error in

      if let networkError = NetworkError(data: data, response: response, error: error) {
        DispatchQueue.main.async {
          completion(.failure(networkError))
        }
      }

      do {
        guard let data = data else {
          preconditionFailure("No error was received but we also don't have data...")
        }

        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(.success(decodedObject))
        }

      } catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.decodingError(error)))
        }
      }
    }.resume()
  }
}
