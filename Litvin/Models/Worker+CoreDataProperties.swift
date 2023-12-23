//
//  Worker+CoreDataProperties.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//
//

import Foundation
import CoreData


extension Worker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Worker> {
        return NSFetchRequest<Worker>(entityName: "Worker")
    }

    @NSManaged public var fio: String?
    @NSManaged public var id: UUID?
    @NSManaged public var work: String?
    @NSManaged public var money: Int32
    @NSManaged public var family: String?
    @NSManaged public var children: Int16
    @NSManaged public var diseases: NSSet?
    @NSManaged public var bonus: NSSet?

}

// MARK: Generated accessors for diseases
extension Worker {

    @objc(addDiseasesObject:)
    @NSManaged public func addToDiseases(_ value: Disease)

    @objc(removeDiseasesObject:)
    @NSManaged public func removeFromDiseases(_ value: Disease)

    @objc(addDiseases:)
    @NSManaged public func addToDiseases(_ values: NSSet)

    @objc(removeDiseases:)
    @NSManaged public func removeFromDiseases(_ values: NSSet)

}

// MARK: Generated accessors for bonus
extension Worker {

    @objc(addBonusObject:)
    @NSManaged public func addToBonus(_ value: Bonus)

    @objc(removeBonusObject:)
    @NSManaged public func removeFromBonus(_ value: Bonus)

    @objc(addBonus:)
    @NSManaged public func addToBonus(_ values: NSSet)

    @objc(removeBonus:)
    @NSManaged public func removeFromBonus(_ values: NSSet)

}

extension Worker : Identifiable {

}
