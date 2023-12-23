//
//  Bonus+CoreDataProperties.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData


extension Bonus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bonus> {
        return NSFetchRequest<Bonus>(entityName: "Bonus")
    }

    @NSManaged public var text: String?
    @NSManaged public var money: Int32

}

extension Bonus : Identifiable {

}
