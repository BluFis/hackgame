//
//  USER+CoreDataProperties.swift
//  
//
//  Created by Apple on 2017/8/25.
//
//

import Foundation
import CoreData


extension USER {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<USER> {
        return NSFetchRequest<USER>(entityName: "USER")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var level: Int16
    @NSManaged public var totalTry: Int16
    @NSManaged public var timeSpend: String?
    @NSManaged public var totalScore: Int32
    @NSManaged public var lastLogin: String?

}
