//
//  DateFormatterExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

extension DateFormatter {
  static var shared: DateFormatter = {
    return DateFormatter()
  }()
}
