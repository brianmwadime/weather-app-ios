//
//  NetworkError.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

/// Custom network handler/service errors
///
enum NetworkError: Error {
  case urlError(Error)
  case transportError(Error)
  case serverError(statusCode: Int)
  case noData
  case decodingError(Error)
  case encodingError(Error)
}

extension NetworkError {

  /// Creates a new Error type based on the error passed or response statusCode not in the 200...299 range.
  ///
  ///  - Parameters:
  ///   - data: The `Data` object.
  ///   - response: The `URLResponse`.
  ///   - error: the `Error` object.
  init?(data: Data?, response: URLResponse?, error: Error?) {
    if let error = error {
      self = .transportError(error)
      return
    }

    if let response = response as? HTTPURLResponse,
       !(200...299).contains(response.statusCode) {
      self = .serverError(statusCode: response.statusCode)
      return
    }

    if data == nil {
      self = .noData
    }

    return nil
  }
}
