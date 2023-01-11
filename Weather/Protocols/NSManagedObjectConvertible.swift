//
//  NSManagedObjectConvertible.swift
//  Weather
//
//  Created by Brian Mwakima on 1/10/23.
//

import Foundation
import CoreData

protocol NSManagedObjectConvertible {

  associatedtype ObjectType

  func toNSManagedObject(in context: NSManagedObjectContext) -> ObjectType?
}
