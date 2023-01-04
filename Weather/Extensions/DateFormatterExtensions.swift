//
//  DateFormatterExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

extension DateFormatter {
  /// Shared `DateFormatter`
  static var shared: DateFormatter = {
    return DateFormatter()
  }()
}
