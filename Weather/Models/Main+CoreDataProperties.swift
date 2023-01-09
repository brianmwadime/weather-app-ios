//
//  Main+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/9/23.
//
//

import Foundation
import CoreData


extension Main {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Main> {
        return NSFetchRequest<Main>(entityName: "Main")
    }

    @NSManaged public var temp: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var feels_like: NSObject?
    @NSManaged public var pressure: Int16
    @NSManaged public var humidity: Double
    @NSManaged public var current: CurrentWeather?

}

extension Main : Identifiable {

}
