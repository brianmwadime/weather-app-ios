//
//  Forecast.swift
//  Weather
//
//  Created by Brian Mwakima on 1/1/23.
//

import Foundation

struct Forecast: Decodable {
  let message: Int
  let list: [Current]
}
