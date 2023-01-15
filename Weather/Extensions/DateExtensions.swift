//
//  DateExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

extension Date {
  /// Returns the day of the week
  var dayOfTheWeek: String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }

  func format(with offset: Double, format: String? = "hh:mm a") -> String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(offset))

    return dateFormatter.string(from: self)
  }

  func format(to format: String? = "hh:mm a") -> String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}
