//
//  MapAnnotationTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/8/23.
//

import XCTest
import CoreLocation
@testable import Weather

final class MapAnnotationTests: XCTestCase {

  func test_mapannotation_has_name_coordinates() {

    let annotation = MapAnnotation(name: "name", coordinate: CLLocationCoordinate2D(latitude: 0.01, longitude: 31.2))

    XCTAssertNotNil(annotation.name)
    XCTAssertNotNil(annotation.coordinate)
  }

}
