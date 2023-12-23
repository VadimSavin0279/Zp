//
//  Disease+CoreDataProperties.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData


extension Disease {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Disease> {
        return NSFetchRequest<Disease>(entityName: "Disease")
    }

    @NSManaged public var start: Date?
    @NSManaged public var end: Date?

}

extension Disease : Identifiable {

}
