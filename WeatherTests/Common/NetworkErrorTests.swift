//
//  NetworkErrorTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/3/23.
//

import XCTest
import Foundation
@testable import Weather

final class NetworkErrorTests: XCTestCase {

  func test_NetworkError_is_transportError() {
    let transportError = NetworkError(data: nil, response: nil, error: NSError())

    XCTAssertEqual(transportError, .transportError(NSError()))
  }

  func test_NetworkError_is_noData() {
    let transportError = NetworkError(data: nil, response: nil, error: nil)

    XCTAssertEqual(transportError, nil)
  }

  func test_NetworkError_is_serverError() {
    let serverError = NetworkError(
      data: nil,
      response: HTTPURLResponse(
        url: URL(string: "http://test.url")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil),
      error: nil)

    XCTAssertEqual(serverError, .serverError(statusCode: 500))
  }

  func test_NetworkError_is_urlError() {
    let urlError = NetworkError.urlError(NSError(domain: "Malformed URL", code: 1200))

    XCTAssertEqual(urlError, .urlError(NSError(domain: "Malformed URL", code: 1200)))
  }

  func test_NetworkError_is_decodingError() {
    let decodingError = NetworkError.decodingError(NSError())

    XCTAssertEqual(decodingError, .decodingError(NSError()))
  }

  func test_NetworkError_is_encodingError() {
    let encodingError = NetworkError.encodingError(NSError())

    XCTAssertEqual(encodingError, .encodingError(NSError()))
  }
}

extension NetworkError: Equatable {
  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    switch (lhs, rhs) {
      case (.transportError(_), .transportError(_)):
        return true
      case (.noData, .noData):
        return true
      case (.serverError(_), .serverError(_)):
        return true
      case (.urlError(_), .urlError(_)):
        return true
      case (.decodingError(_), .decodingError(_)):
        return true
      case (.encodingError(_), .encodingError(_)):
        return true
      default:
        return false
    }
  }
}
