//
//  PersistentContainer.swift
//  Weather
//
//  Created by Brian Mwakima on 1/7/23.
//

import CoreData

public class PersistentContainer {

  /// CoreData context object
  ///
  public static var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  private init() {}

  /// Core Data stack
  ///
  public static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Weather")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()

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
