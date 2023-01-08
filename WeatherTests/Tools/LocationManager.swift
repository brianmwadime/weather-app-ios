//
//  LocationManager.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/8/23.
//

import Foundation
import CoreLocation

protocol LocationManager {

  // CLLocationManager Properties
  var location: CLLocation? { get }
  var delegate: CLLocationManagerDelegate? { get set }
  var distanceFilter: CLLocationDistance { get set }
  var pausesLocationUpdatesAutomatically: Bool { get set }
  var allowsBackgroundLocationUpdates: Bool { get set }

  // CLLocationManager Methods
  func requestWhenInUseAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
}

extension CLLocationManager: LocationManager {}
