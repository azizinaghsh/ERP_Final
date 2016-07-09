//
//  PermissionEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/5/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PermissionEntity {

    @NSManaged var can_create_project: NSNumber?
    @NSManaged var can_create_requirement: NSNumber?
    @NSManaged var can_create_resource: NSNumber?
    @NSManaged var can_create_user: NSNumber?
    @NSManaged var title: String?
    @NSManaged var myUsers: NSSet?
}
