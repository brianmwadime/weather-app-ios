//
//  PersistentContainer.swift
//  Weather
//
//  Created by Brian Mwakima on 1/7/23.
//

import CoreData

final class PersistentContainer {

  /// CoreData context object
  ///
  public static var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  /// Core Data stack
  ///
  public static var persistentContainer: NSPersistentContainer = {

    let container = NSPersistentContainer(name: "Weather")

    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()

  private init() {

  }

  /// Core Data Saving support
  /// 
  public static func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
