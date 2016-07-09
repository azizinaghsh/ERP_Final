//
//  ProjectEntity+CoreDataProperties.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/7/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProjectEntity {

    @NSManaged var budgetLimit: NSNumber?
    @NSManaged var humanResourceLmit: NSNumber?
    @NSManaged var endDate: String?
    @NSManaged var projectDescription: String?
    @NSManaged var projectName: String?
    @NSManaged var startDate: String?
    @NSManaged var isProject: NSNumber?
    @NSManaged var manager: UserEntity?
    @NSManaged var myCategory: ProjectCategoriesEntity?
    @NSManaged var products: NSSet?
    @NSManaged var requirements: NSSet?
    @NSManaged var subProjects: NSSet?
    @NSManaged var superProject: ProjectEntity?
    @NSManaged var allocations: NSSet?

}
