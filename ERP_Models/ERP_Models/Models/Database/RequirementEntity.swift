//
//  RequirementEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class RequirementEntity: Entity
{
    override func setupEntity(object: NSObject)
    {
        let requirement = object as! Requirement
        self.amount = requirement.amount
        self.createdAt = requirement.createdAt
        self.estimatedUseDuration = requirement.estimatedUseDuration
        let projectEntity = requirement.project.myEntity as! ProjectEntity
        let resourceEntity = requirement.resource.myEntity as! ResourceEntity
        self.myResource = resourceEntity
        self.myProject = projectEntity
        resourceEntity.mutableSetValueForKey("requirements").addObject(self)
        projectEntity.mutableSetValueForKey("requirements").addObject(self)
    }
    
    override class func getMyType () -> String
    {
        return "Requirement"
    }
}
