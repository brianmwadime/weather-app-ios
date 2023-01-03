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
  var favoriteRepository: MockFavoritesRepository!

  override func setUpWithError() throws {
    try super.setUpWithError()

    favoriteRepository = MockFavoritesRepository()

    sut = FavoritesViewModel(repository: favoriteRepository)
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

}

class FavoritesViewModel: ObservableObject {
  @Published var query: String?
  @Published var favorites: [FavoriteLocation] = []
  @Published var error: Error?

  let repository: any RepositoryType

  init(repository: RepositoryType) {
    self.repository = repository
  }

  @discardableResult
  func save(city: String, latitude: Double, longitude: Double) -> FavoriteLocation {
    let favorite = FavoriteLocation(context: repository.context)
    favorite.city = city
    favorite.latitude = latitude
    favorite.longitude = longitude
    repository.create(favorite)
    return favorite
  }

  func update() {

  }

  func fetch() {
    let result = repository.fetch(FavoriteLocation.self, predicate: nil, limit: nil)

    switch result {
      case .success(let favorites):
        self.favorites = favorites
      case .failure(let error):
        self.error = error
    }
  }

  func delete(_ location: FavoriteLocation) {
    repository.delete(location)
  }

}

class MockFavoritesRepository: RepositoryType {

  var context: NSManagedObjectContext { persistentContainer.viewContext }

  lazy var persistentContainer: NSPersistentContainer = {
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

  func create(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {

    }
  }

//  func update(_ object: FavoriteLocation) {
//    do {
//      try context.save()
//    } catch {
//      fatalError("error saving context while updating an object")
//    }
//  }

//  func delete(_ object: FavoriteLocation) {
//    context.delete(object)
//  }

  func fetchOne<T>(_ object: T.Type, predicate: NSPredicate?) -> Result<T?, Error> where T : NSManagedObject {
    let request = object.fetchRequest()
    request.predicate = predicate
    request.fetchLimit = 1
    do {
      let result = try context.fetch(request) as? [T]
      return .success(result?.first)
    } catch {
      return .failure(error)
    }
  }

  func fetch<T>(_ object: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error> where T : NSManagedObject {
    let request = object.fetchRequest()
    request.predicate = predicate
    if let limit = limit {
      request.fetchLimit = limit
    }
    do {
      let result = try context.fetch(request)
      return .success(result as? [T] ?? [])
    } catch {
      return .failure(error)
    }
  }

  func update(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      fatalError("error saving context while updating an object")
    }
  }

  func delete(_ object: NSManagedObject) {
    context.delete(object)
  }
}

protocol RepositoryType {

  var context: NSManagedObjectContext { get }

  func create(_ object: NSManagedObject)
  func fetchOne<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?) -> Result<T?, Error>
  func fetch<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error>
  func update(_ object: NSManagedObject)
  func delete(_ object: NSManagedObject)
}

@objc(FavoriteLocation)
class FavoriteLocation: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLocation> {
    return NSFetchRequest<FavoriteLocation>(entityName: "FavoriteLocation")
  }

  @NSManaged public var city: String
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
}
