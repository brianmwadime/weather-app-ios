//
//  MapAnnotation.swift
//  Weather
//
//  Created by Brian Mwakima on 1/8/23.
//

import Foundation
import MapKit

struct MapAnnotation: Identifiable {
  let id = UUID()

  public var name: String

  public var coordinate: CLLocationCoordinate2D
}
