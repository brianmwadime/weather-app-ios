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

  func date(with offset: Double?) -> String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = "hh:mm a"

    if let offset = offset {

      return dateFormatter.string(from: self.addingTimeInterval(offset))
    }

    return dateFormatter.string(from: self)
  }
}
