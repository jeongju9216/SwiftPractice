//
//  Entity+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by 유정주 on 2023/01/23.
//
//

import Foundation
import CoreData

extension Keyword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Keyword> {
        return NSFetchRequest<Keyword>(entityName: "Keyword")
    }

    @NSManaged public var keyword: String?
    @NSManaged public var createdAt: Date?

}

extension Keyword : Identifiable {

}
