//
//  DefaultNetworkService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import Foundation

public class DefaultNetworkService: NetworkService {
  public init() {}
  func execute<T>(with request: URLRequest, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
    URLSession.shared.dataTask(with: request) { data, response, error in

      if let networkError = NetworkError(data: data, response: response, error: error) {
        DispatchQueue.main.async {
          completion(.failure(networkError))
        }
      }

      do {
        guard let data = data else {
          DispatchQueue.main.async {
            completion(.failure(NetworkError.noData))
          }
          return
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
