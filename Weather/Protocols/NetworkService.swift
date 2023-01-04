//
//  NetworkService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import Foundation

/// Network Service Protocol
///
protocol NetworkService {

  /// Executes network requests
  ///
  /// - Parameters:
  ///  - request: a `URLRequest` instance.
  ///  - model: request result model.
  ///  - completion: `Result` closure.
  func execute<T: Codable>(with request: URLRequest, model: T.Type,
                             completion: @escaping(Result<T, Error>) -> Void)
}
