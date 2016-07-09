//
//  ProjectEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/7/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class ProjectEntity: Entity {

    override func setupEntity(object: NSObject)
    {
        let project = object as! Project
        self.projectName = project.projectName as String
        self.projectDescription = project.projectDescription as? String
        self.startDate = project.startDate as String
        self.endDate = project.endDate as? String
        self.budgetLimit = project.budgetLimit
        self.humanResourceLmit = project.humanResourceLimit
        self.myCategory = ProjectCatalog.getInstance().getCategoriesEntity(project.category)
        self.manager = UserCatalog.getInstance().FindUserEntity((project.projectManager?.username) as String?)
        self.isProject = project.isProject
    }
    
    override class func getMyType () -> String
    {
        return "Project"
    }
}
