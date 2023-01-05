//
//  FavoriteLocationsRepository.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import CoreData

class FavoriteLocationsRepository: RepositoryType {

  var context: NSManagedObjectContext { persistentContainer.viewContext }

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Weather")

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Failed to load stores: \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  func create(_ object: NSManagedObject) throws {
    try context.save()
  }

  func fetchOne<T>(_ object: T.Type, predicate: NSPredicate?) -> Result<T?, Error> where T: NSManagedObject {
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

  func fetch<T>(_ object: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error> where T: NSManagedObject {
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
    do {
      try context.save()
    } catch {
      fatalError("error saving context while updating an object")
    }
  }
}
