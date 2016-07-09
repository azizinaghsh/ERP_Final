//
//  AllocationEntity.swift
//  ERP_Models
//
//  Created by Hossein Azizi on 7/3/16.
//  Copyright © 2016 Hossein Azizi. All rights reserved.
//

import Foundation
import CoreData


class AllocationEntity: Entity {

    override func setupEntity(object: NSObject)
    {
        let allocation = object as! Allocation
        self.amount = allocation.amount
        self.createdAt = allocation.createdAt
        self.estimatedUseDuration = allocation.estimatedUseDuration
        self.isCurrent     = allocation.isCurrent
        self.releaseTime   = allocation.releaseTime as? String
        let projectEntity  = allocation.project.myEntity as! ProjectEntity
        let resourceEntity = allocation.resource.myEntity as! ResourceEntity
        self.myResource = resourceEntity
        self.myProject = projectEntity
        resourceEntity.mutableSetValueForKey("allocations").addObject(self)
        projectEntity.mutableSetValueForKey("allocations").addObject(self)
    }
    
    override class func getMyType () -> String
    {
        return "Allocation"
    }
}
