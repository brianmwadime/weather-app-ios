//
//  FavoriteLocationRepositoryTests.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/4/23.
//

import XCTest
import CoreData
@testable import Weather

final class FavoriteLocationRepositoryTests: XCTestCase {

  var sut: FavoriteLocationsRepository!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = FavoriteLocationsRepository()
    sut.persistentContainer = {
      let container = NSPersistentContainer(name: "Weather")

      // create a persistent store description that informs the persistent container that it should write data to /dev/null
      // while using the default SQLite storage mechanism Writing to /dev/null effectively uses an in-memory store,
      // except you get all the features that you also get from the SQLite store that your app uses
      let description = NSPersistentStoreDescription()
      description.url = URL(fileURLWithPath: "/dev/null")
      container.persistentStoreDescriptions = [description]

      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Failed to load stores: \(error), \(error.userInfo)")
        }
      })
      return container
    }()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func test_FavoriteLocationRepository_context_exists() {

    XCTAssertNotNil(sut.context)
  }

  func test_FavoriteLocationRepository_persistenceContainer_exists() {

    XCTAssertNotNil(sut.persistentContainer)
  }

  func test_FavoriteLocationRepository_adds_object() throws {
    let city = "That Place"
    let latitude = 1.2345
    let longitude = 32.234

    let favoriteLocation = FavoriteLocation(context: sut.context)
    favoriteLocation.city = city
    favoriteLocation.latitude = latitude
    favoriteLocation.longitude = longitude

    try sut.create(favoriteLocation)

    let result = sut.fetchOne(FavoriteLocation.self, predicate: nil)

    let savedLocation = try result.get()

    XCTAssertEqual(savedLocation, favoriteLocation)
  }

  func test_FavoriteLocationRepository_updates_object() throws {
    let city = "That Place"
    let latitude = 1.2345
    let longitude = 32.234

    let favoriteLocation = FavoriteLocation(context: sut.context)
    favoriteLocation.city = city
    favoriteLocation.latitude = latitude
    favoriteLocation.longitude = longitude

    try sut.create(favoriteLocation)

    let cityUpdate = "That Place 2"

    let result = sut.fetchOne(FavoriteLocation.self, predicate: nil)

    let favoriteToUpdate = try result.get()

    favoriteToUpdate?.city = cityUpdate

    try sut.update(favoriteToUpdate!)

    let updateResult = sut.fetchOne(FavoriteLocation.self, predicate: nil)

    let updatedFavoriteLocation = try updateResult.get()

    XCTAssertEqual(updatedFavoriteLocation, favoriteToUpdate)
  }

  func test_FavoriteLocationRepository_deletes_object() throws {
    let city = "That Place"
    let latitude = 1.2345
    let longitude = 32.234

    let favoriteLocation = FavoriteLocation(context: sut.context)
    favoriteLocation.city = city
    favoriteLocation.latitude = latitude
    favoriteLocation.longitude = longitude

    try sut.create(favoriteLocation)

    let result = sut.fetchOne(FavoriteLocation.self, predicate: nil)

    let favoriteToDelete = try result.get()

    try sut.delete(favoriteToDelete!)

    let results = sut.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    let favoriteLocations = try results.get()

    XCTAssertEqual(favoriteLocations.count, 0)
  }

  func test_FavoriteLocationRepository_fetches_objects() throws {
    let city = "That Place"
    let latitude = 1.2345
    let longitude = 32.234

    let favoriteLocation = FavoriteLocation(context: sut.context)
    favoriteLocation.city = city
    favoriteLocation.latitude = latitude
    favoriteLocation.longitude = longitude

    try sut.create(favoriteLocation)

    let result = sut.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    let savedLocations = try result.get()

    XCTAssertNotNil(savedLocations)
    XCTAssertEqual(savedLocations.count, 1)
  }

}
