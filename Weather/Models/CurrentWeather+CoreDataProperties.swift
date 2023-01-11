//
//  CurrentWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/11/23.
//
//

import Foundation
import CoreData


extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "Current")
    }

    @NSManaged public var dt: Date?
    @NSManaged public var timezone: Double
    @NSManaged public var lastUpdated: Date
    @NSManaged public var main: MainCurrent
    @NSManaged public var weather: NSSet?

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

extension CurrentWeather : Identifiable {

}
