//
//  NSSetExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation

/// Returns Array from optional NSSet.
/// 
extension Optional where Wrapped == NSSet {
  func array<T: Hashable>(of: T.Type) -> [T] {
    if let set = self as? Set<T> {
      return Array(set)
    }
    return [T]()
  }
}
