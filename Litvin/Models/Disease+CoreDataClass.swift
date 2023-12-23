//
//  Disease+CoreDataClass.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData

@objc(Disease)
public class Disease: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Disease"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
}
