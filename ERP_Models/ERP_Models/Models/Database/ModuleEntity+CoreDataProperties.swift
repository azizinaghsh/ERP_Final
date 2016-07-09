//
//  ModuleEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/6/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ModuleEntity {

    @NSManaged var moduleDescription: String?
    @NSManaged var category: ModuleCategoriesEntity?
    @NSManaged var creators: NSSet?
    @NSManaged var maintenances: NSSet?
    @NSManaged var product: ProjectEntity?

}
