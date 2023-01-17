//
//  WeatherForecast+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/14/23.
//
//

import Foundation
import CoreData

extension WeatherForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecast> {
        return NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    }

    @NSManaged public var lastUpdated: Date
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension WeatherForecast {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: CurrentWeather)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: CurrentWeather)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension WeatherForecast: Identifiable {

}

extension WeatherForecast: ModelConvertible {
  func toModel() -> Forecast {
    let forecasts = self.list.array(of: CurrentWeather.self)

    var forecastArray: [Current] = []

    for forecast in forecasts {
      forecastArray.append(
        forecast.toModel()
      )
    }

    return Forecast(
      message: 200,
      list: forecastArray)
  }
}
