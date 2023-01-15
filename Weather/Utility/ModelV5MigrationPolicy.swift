//
//  DateV5MigrationPolicy.swift
//  Weather
//
//  Created by Brian Mwakima on 1/14/23.
//

import Foundation
import CoreData

class ModelV5MigrationPolicy: NSEntityMigrationPolicy {

  override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
    try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
  }

  @objc func dateToTimeStamp(_ old: Date) -> Double {
    return old.timeIntervalSince1970
  }
}
