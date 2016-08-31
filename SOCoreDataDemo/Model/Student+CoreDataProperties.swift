//
//  Student+CoreDataProperties.swift
//  SOCoreDataDemo
//
//  Created by Hitesh on 8/30/16.
//  Copyright © 2016 myCompany. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {
    @NSManaged var first_name: String?
    @NSManaged var rollno: NSNumber?
    @NSManaged var last_name: String?

}
