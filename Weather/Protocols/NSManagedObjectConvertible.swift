//
//  NSManagedObjectConvertible.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import CoreData

protocol NSManagedObjectConvertible {
  /// The CoreData model to convert to.
  /// Should be an `NSManagedObject` subclass.
  associatedtype ObjectType: NSManagedObject
  /// Converts Model to  specified `NSManagedObject` subclass
  func toNSManagedObject(in context: NSManagedObjectContext) -> ObjectType?
}
