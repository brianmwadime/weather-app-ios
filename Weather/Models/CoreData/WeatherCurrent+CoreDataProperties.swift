//
//  WeatherCurrent+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/14/23.
//
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
    @NSManaged public var ofCurrent: CurrentWeather?

}

extension WeatherCurrent: Identifiable {

}

extension WeatherCurrent: ModelConvertible {
  typealias ModelType = Current.Weather

  func toModel() -> Current.Weather? {
    return Current.Weather(
      id: Int(self.weather_id),
      main: self.main,
      description: self.main_description,
      icon: self.icon)
  }
}
