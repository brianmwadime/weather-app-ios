//
//  CurrentWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/14/23.
//
//

import Foundation
import CoreData

extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "CurrentWeather")
    }

    @NSManaged public var dt: Date
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var timezone: Double
    @NSManaged public var main: MainCurrent
    @NSManaged public var weather: NSSet?
    @NSManaged public var ofWeatherForcast: WeatherForecast?

}

// MARK: Generated accessors for weather
extension CurrentWeather {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherCurrent)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherCurrent)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension CurrentWeather: Identifiable {

}

extension CurrentWeather: ModelConvertible {
  func toModel() -> Current {
    let weathers = self.weather.array(of: WeatherCurrent.self)

    var weatherArray: [Current.Weather] = []

    for weather in weathers {
      weatherArray.append(
        weather.toModel()
      )
    }

    return Current(
      dt: self.dt.timeIntervalSince1970,
      coord: nil,
      weather: weatherArray,
      main: self.main.toModel(),
      rain: nil,
      wind: Current.Wind.empty(),
      clouds: Current.Clouds.empty(),
      timezone: self.timezone,
      lastUpdated: self.lastUpdated)
  }
}
