//
//  CoreDataRepository.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import CoreData

class CoreDataRepository: RepositoryType {

  var context: NSManagedObjectContext { persistentContainer.viewContext }

  var persistentContainer: NSPersistentContainer

  init() {
    persistentContainer = PersistentContainer.persistentContainer
  }

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

  func update(_ object: NSManagedObject) throws {
    try context.save()
  }

  func delete(_ object: NSManagedObject) throws {
    context.delete(object)
    try context.save()
  }

  func deleteAll(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) throws {
    let deleteRequest = NSBatchDeleteRequest(
      fetchRequest: fetchRequest
    )
    deleteRequest.resultType = .resultTypeObjectIDs

    let batchDelete = try context.execute(deleteRequest) as? NSBatchDeleteResult

    guard let deleteResult = batchDelete?.result
            as? [NSManagedObjectID]
    else { return }

    let deletedObjects: [AnyHashable: Any] = [
      NSDeletedObjectsKey: deleteResult
    ]

    // Merge the delete changes into the managed
    // object context
    NSManagedObjectContext.mergeChanges(
      fromRemoteContextSave: deletedObjects,
      into: [context])
  }
}
