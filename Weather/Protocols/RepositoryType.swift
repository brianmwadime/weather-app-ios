//
//  RepositoryType.swift
//  Weather
//
//  Created by Brian Mwakima on 1/4/23.
//

import Foundation
import CoreData

protocol RepositoryType {

  var context: NSManagedObjectContext { get }

  func create(_ object: NSManagedObject)
  func fetchOne<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?) -> Result<T?, Error>
  func fetch<T: NSManagedObject>(_ object: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error>
  func update(_ object: NSManagedObject)
  func delete(_ object: NSManagedObject)
}
