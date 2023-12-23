//
//  Bonus+CoreDataClass.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData

@objc(Bonus)
public class Bonus: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Bonus"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
}
