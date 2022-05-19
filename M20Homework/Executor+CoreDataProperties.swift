//
//  Executor+CoreDataProperties.swift
//  M20Homework
//
//  Created by Андрей Антонен on 11.04.2022.
//
//

import Foundation
import CoreData


extension Executor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Executor> {
        return NSFetchRequest<Executor>(entityName: "Executor")
    }

    @NSManaged public var country: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?

}

extension Executor : Identifiable {

}
