//
//  WeatherCurrent+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import CoreData

extension WeatherCurrent {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCurrent> {
    return NSFetchRequest<WeatherCurrent>(entityName: "Weather")
  }

  @NSManaged public var icon: String
  @NSManaged public var main: String
  @NSManaged public var main_description: String
  @NSManaged public var weather_id: Int16
  @NSManaged public var current: CurrentWeather?

}

extension WeatherCurrent: Identifiable {

}
