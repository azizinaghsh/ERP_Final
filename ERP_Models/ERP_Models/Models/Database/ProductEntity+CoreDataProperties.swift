//
//  ProductEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/8/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProductEntity {

    @NSManaged var module: ModuleEntity?
    @NSManaged var project: ProjectEntity?
    @NSManaged var title: String?

}
