//
//  Entity+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by 유정주 on 2023/01/23.
//
//

import Foundation
import CoreData


extension Phone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phone> {
        return NSFetchRequest<Phone>(entityName: "Phone")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var createdAt: Date?

}

extension Phone : Identifiable {

}
