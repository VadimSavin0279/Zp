//
//  Worker+CoreDataClass.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData

@objc(Worker)
public class Worker: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Worker"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
}
