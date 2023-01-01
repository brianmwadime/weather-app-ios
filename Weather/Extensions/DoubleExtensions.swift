//
//  DoubleExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

extension Double {
  func roundDouble() -> String {
    return String(format: "%.0f", self)
  }
}
