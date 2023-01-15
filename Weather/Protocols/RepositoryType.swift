//
//  RepositoryType.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import CoreData

protocol RepositoryType {

  var context: NSManagedObjectContext { get }

  var persistentContainer: NSPersistentContainer { get set }

  func create(_ object: NSManagedObject) throws
  func fetchOne<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?) -> Result<T?, Error>
  func fetch<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error>
  func update(_ object: NSManagedObject) throws
  func delete(_ object: NSManagedObject) throws
  func deleteAll(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) throws
}
