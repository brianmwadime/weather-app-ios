//
//  MockNetworkService.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/3/23.
//

import Foundation
@testable import Weather

struct MockNetworkService: NetworkService {
  let data: Data?
  let error: Error?

  func execute<T>(with request: URLRequest, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {

    do {
      guard let data = data else {
        preconditionFailure("No error was received but we also don't have data...")
      }

      let decodedObject = try JSONDecoder().decode(T.self, from: data)
      completion(.success(decodedObject))

    } catch {
      completion(.failure(NetworkError.decodingError(error)))
    }

  }
}
