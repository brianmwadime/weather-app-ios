//
//  Weather+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/9/23.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var main: String?
    @NSManaged public var main_description: String?
    @NSManaged public var icon: String?
    @NSManaged public var current: CurrentWeather?

}

extension Weather : Identifiable {

}
