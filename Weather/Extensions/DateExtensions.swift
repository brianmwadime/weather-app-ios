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

  func date(with offset: Int?) -> String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = "hh:mm a"
    if let offset = offset {
//      dateFormatter.timeZone = TimeZone(secondsFromGMT: offset)
      let epochDate = self.timeIntervalSince1970
      let timezoneEpochOffset = epochDate + Double(offset)

      return dateFormatter.string(from: Date(timeIntervalSince1970: timezoneEpochOffset))
    }

    return dateFormatter.string(from: self)
  }

  func format(to format: String? = "hh:mm a") -> String {
    let dateFormatter = DateFormatter.shared

    if let format = format {
      dateFormatter.dateFormat = format
    }

    return dateFormatter.string(from: self)
  }
}
