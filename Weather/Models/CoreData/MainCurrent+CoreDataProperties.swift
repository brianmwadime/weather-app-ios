//
//  MainCurrent+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/14/23.
//
//

import Foundation
import CoreData

extension MainCurrent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainCurrent> {
        return NSFetchRequest<MainCurrent>(entityName: "Main")
    }

    @NSManaged public var feels_like: Double
    @NSManaged public var humidity: Double
    @NSManaged public var pressure: Double
    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var ofCurrent: CurrentWeather?

}

extension MainCurrent: Identifiable {

}

extension MainCurrent: ModelConvertible {
  typealias ModelType = Current.Main

  func toModel() -> Current.Main? {
    return Current.Main(
      temp: self.temp,
      feels_like: self.feels_like,
      temp_min: self.temp_min,
      temp_max: self.temp_max,
      pressure: Int(self.pressure),
      humidity: Int(self.humidity),
      sea_level: 0,
      grnd_level: 0)
  }
}
