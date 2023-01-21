//
//  LocationService.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import MapKit
import os


 /// The LocationService provides the user's current location, if the user has authorized it. You
 /// can also enable monitoring of location changes and automatically update the weather on the
 /// screen has the user moves around.
 ///
final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {

  /// LocationService uses its own status enum to simplify knowing if the app can or
  /// cannot get the device's current location.
  enum Status {
    case waiting
    case available
    case denied
  }

  /// `CLLocationManager` instance
  private let locationManager = CLLocationManager()

  /// Location status
  @Published var status = Status.waiting
  /// Last location
  @Published var lastLocation: CLLocation? = nil

  /// Start `LocationService`
  func start() {
    locationManager.delegate = self

    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }

  /// CLLocationManagerDelegate Implementations
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    // if the app is authorized to get the current location, that location may be
    // immediately availble. If not, then the app has to request location updates
    // until that is settled.
    if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
      if let location = manager.location {
        geocode(location: location)
      } else {
        status = .waiting // isn't really available yet
        manager.startUpdatingLocation()
      }
    } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
      status = .denied
      lastLocation = nil
    } else if manager.authorizationStatus == .notDetermined {
      status = .waiting
      manager.requestWhenInUseAuthorization()
    }

    // if the app is not authorized, then the lastLocation remains nil. Note that if the user decides to
    // disable location services for the app, that will trigger this delegate function again, but with
    // a different value for authorizationStatus. We leave the lastLocation alone since this app only
    // cares to get the location as a convenience to the user.
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location manager has failed with error: \(error)")
    status = .denied
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      geocode(location: location)

      manager.stopUpdatingLocation()
    }
  }

  /// Use reverse geocoding to name the current location (well, the location given as parameter). If
  /// that fails, default to a generic title.
  ///
  private func geocode(location: CLLocation) {
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
      self.lastLocation = location
      self.status = .available
    }
  }

  /// Stop `LocationService`
  func stop() {
    locationManager.delegate = nil
    locationManager.stopUpdatingLocation()
  }
}
