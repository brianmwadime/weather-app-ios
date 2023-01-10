//
//  MainCurrent+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
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
  @NSManaged public var current: CurrentWeather?

}

extension MainCurrent: Identifiable {

}
