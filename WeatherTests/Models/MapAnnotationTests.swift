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

  func test_MapAnnotation_has_name_coordinates() {

    let sut = MapAnnotation(id: UUID(), name: "name", coordinate: CLLocationCoordinate2D(latitude: 0.01, longitude: 31.2))

    XCTAssertNotNil(sut)
    XCTAssertNotNil(sut.name)
    XCTAssertNotNil(sut.coordinate)
  }

  func test_MapAnnotation_is_my_location() {

    let sut = MapAnnotation(id: UUID(), name: "My Location", coordinate: CLLocationCoordinate2D(latitude: 0.01, longitude: 31.2))

    XCTAssertTrue(sut.isMyLocation)
  }

}
