//
//  CurrentWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/5/23.
//
//

import Foundation
import CoreData

extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "Current")
    }


}

extension CurrentWeather: Identifiable {

}
