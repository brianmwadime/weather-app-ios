//
//  ModelConvertible.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import CoreData

protocol ModelConvertible {
  /// The Model to convert to that conforms to Codable
  associatedtype ModelType: Codable

  /// Converts a conforming instance to `ModelType` instance
  func toModel() -> ModelType
}
