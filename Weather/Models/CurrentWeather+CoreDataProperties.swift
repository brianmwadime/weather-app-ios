//
//  CurrentWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/9/23.
//
//

import Foundation
import CoreData


extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "Current")
    }

    @NSManaged public var timezone: Int16
    @NSManaged public var dt: Date?
    @NSManaged public var main: Main?
    @NSManaged public var weather: NSSet?

}

// MARK: Generated accessors for weather
extension CurrentWeather {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: Weather)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: Weather)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension CurrentWeather : Identifiable {

}
