//
//  LocationManager.swift
//  Weather
//
//  Created by Brian Mwakima on 1/3/23.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject {
  private let locationManager = CLLocationManager()
  @Published var location: CLLocation? = nil

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }

  func stopUpdates() {
    locationManager.stopUpdatingLocation()
  }

  func startUpdates() {
    locationManager.startUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    guard let location = locations.last else {
      return
    }

    DispatchQueue.main.async {
      self.location = location
    }
  }
}
