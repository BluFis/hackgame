//
//  LEVELS+CoreDataProperties.swift
//  
//
//  Created by Apple on 2017/8/25.
//
//

import Foundation
import CoreData


extension LEVELS {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LEVELS> {
        return NSFetchRequest<LEVELS>(entityName: "LEVELS")
    }

    @NSManaged public var level: Int16
    @NSManaged public var get: Bool
    @NSManaged public var tryTimes: Int16
    @NSManaged public var timeSpend: String?
    @NSManaged public var score: Int32

}
