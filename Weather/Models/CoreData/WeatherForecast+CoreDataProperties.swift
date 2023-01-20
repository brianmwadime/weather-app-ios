//
//  WeatherForecast+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/17/23.
//
//

import Foundation
import CoreData

extension WeatherForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecast> {
        return NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    }

    @NSManaged public var lastUpdated: Date?
    @NSManaged public var list: NSOrderedSet?

}

// MARK: Generated accessors for list
extension WeatherForecast {

    @objc(insertObject:inListAtIndex:)
    @NSManaged public func insertIntoList(_ value: CurrentWeather, at idx: Int)

    @objc(removeObjectFromListAtIndex:)
    @NSManaged public func removeFromList(at idx: Int)

    @objc(insertList:atIndexes:)
    @NSManaged public func insertIntoList(_ values: [CurrentWeather], at indexes: NSIndexSet)

    @objc(removeListAtIndexes:)
    @NSManaged public func removeFromList(at indexes: NSIndexSet)

    @objc(replaceObjectInListAtIndex:withObject:)
    @NSManaged public func replaceList(at idx: Int, with value: CurrentWeather)

    @objc(replaceListAtIndexes:withList:)
    @NSManaged public func replaceList(at indexes: NSIndexSet, with values: [CurrentWeather])

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: CurrentWeather)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: CurrentWeather)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSOrderedSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSOrderedSet)

}

extension WeatherForecast: Identifiable {

}

extension WeatherForecast: ModelConvertible {
  func toModel() -> Forecast {
    var forecastArray: [Current] = []

    if let list = self.list {
      for case let forecast as CurrentWeather in list.array {
        forecastArray.append(
          forecast.toModel()
        )
      }
    }

    return Forecast(
      message: 200,
      list: forecastArray)
  }
}
