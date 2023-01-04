//
//  FavoriteLocation+CoreDataClass.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import CoreData

@objc(FavoriteLocation)
class FavoriteLocation: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLocation> {
    return NSFetchRequest<FavoriteLocation>(entityName: "FavoriteLocation")
  }

  @NSManaged public var city: String
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
}
