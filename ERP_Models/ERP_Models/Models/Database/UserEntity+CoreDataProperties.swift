//
//  UserEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserEntity {

    @NSManaged var fname: String?
    @NSManaged var lname: String?
    @NSManaged var password: String?
    @NSManaged var username: String?
    @NSManaged var myPermission: PermissionEntity?
    @NSManaged var myProjects: NSSet?

}
