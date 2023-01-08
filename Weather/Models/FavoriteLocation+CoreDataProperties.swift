//
//  FavoriteLocation+CoreDataProperties.swift
//  Weather
//
//  Created by Brian Mwakima on 1/5/23.
//
//

import Foundation
import CoreData
import MapKit

extension FavoriteLocation {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLocation> {
      return NSFetchRequest<FavoriteLocation>(entityName: "FavoriteLocation")
  }

  @NSManaged public var city: String
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double

}

extension FavoriteLocation: Identifiable {

}

extension FavoriteLocation: MKAnnotation {

  public var title: String? { city }

  public var name: String { city }

  public var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
