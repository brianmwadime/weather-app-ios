//
//  DateExtensions.swift
//  Weather
//
//  Created by Brian Mwakima on 1/2/23.
//

import Foundation

extension Date {
  var dayOfTheWeek: String {
    let dateFormatter = DateFormatter.shared
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }
}
