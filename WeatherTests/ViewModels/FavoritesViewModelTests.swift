//
//  FavoritesViewModel.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/3/23.
//

import Foundation
import XCTest
import Combine
import CoreData
@testable import Weather

final class FavoritesViewModelTests: XCTestCase {
  var sut: FavoritesViewModel?
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  var favoriteRepository: MockCoreDataRepository!

  override func setUpWithError() throws {
    try super.setUpWithError()

    favoriteRepository = MockCoreDataRepository()

    sut = FavoritesViewModel(repository: favoriteRepository, locationService: LocationService())
  }

  override func tearDownWithError() throws {
    sut = nil
    favoriteRepository = nil
    try super.tearDownWithError()
  }

  func test_FavouritesViewModel_save_FavoriteLocation() {
    let city = "That Place"
    let latitude = 1.2345
    let longitude = 32.234

    let favoriteSaved = sut?.save(city: city, latitude: latitude, longitude: longitude)

    XCTAssertEqual(favoriteSaved?.city, city)
    XCTAssertEqual(favoriteSaved?.latitude, latitude)
    XCTAssertEqual(favoriteSaved?.longitude, longitude)
  }

  func test_FavouritesViewModel_fetch_FavoriteLocations() {
    let expectation = XCTestExpectation(description: "Should have 4 favorite locations")

    for city in ["That Place", "This Place", "Other Place", "No other Place"] {
      sut?.save(city: city, latitude: 1.2345, longitude: 31.2345)
    }

    sut?.$favorites
      // Drop first to ignore the initial value
      .dropFirst()
      .sink { favorites in
        XCTAssertNotNil(favorites)
        XCTAssertEqual(favorites.count, 4)
        expectation.fulfill()
      }.store(in: &cancellables)
    sut?.fetch()

    wait(for: [expectation], timeout: 1)
  }

  func test_FavouritesViewModel_fetch_MapAnnotation() {
    let expectation = XCTestExpectation(description: "Should have 4 favorite locations")

    for city in ["That Place", "This Place", "Other Place", "No other Place"] {
      sut?.save(city: city, latitude: 1.2345, longitude: 31.2345)
    }

    sut?.$favorites
    // Drop first to ignore the initial value
      .dropFirst()
      .sink { favorites in
        XCTAssertNotNil(favorites)
        XCTAssertEqual(favorites.count, 4)
        expectation.fulfill()
      }.store(in: &cancellables)
    sut?.fetch()

    wait(for: [expectation], timeout: 1)

    let annotations = sut?.getAnnotations()

    XCTAssertNotNil(annotations)
  }

}
