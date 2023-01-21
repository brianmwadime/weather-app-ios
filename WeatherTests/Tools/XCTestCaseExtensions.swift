//
//  XCTestCaseExtensions.swift
//  WeatherTests
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import XCTest
import CoreData
@testable import Weather

extension XCTestCase {

  func getCoreDataContext() -> NSManagedObjectContext {
    let sut = CoreDataRepository()
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

    return sut.context
  }
}
