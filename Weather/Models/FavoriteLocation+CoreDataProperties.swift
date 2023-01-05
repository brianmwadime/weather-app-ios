//
//  FavoriteLocation+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/5/23.
//
//

import Foundation
import CoreData

extension FavoriteLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLocation> {
        return NSFetchRequest<FavoriteLocation>(entityName: String(describing: FavoriteLocation.self))
    }

    @NSManaged public var city: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension FavoriteLocation: Identifiable {

}
